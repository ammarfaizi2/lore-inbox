Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSFUORO>; Fri, 21 Jun 2002 10:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSFUORN>; Fri, 21 Jun 2002 10:17:13 -0400
Received: from [62.70.58.70] ([62.70.58.70]:62082 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316614AbSFUORK> convert rfc822-to-8bit;
	Fri, 21 Jun 2002 10:17:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: "Taavo Raykoff" <traykoff@snet.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 IDE channels block each other under load?
Date: Fri, 21 Jun 2002 16:17:14 +0200
User-Agent: KMail/1.4.1
References: <000801c2192c$72e37580$ad0aa8c0@trws>
In-Reply-To: <000801c2192c$72e37580$ad0aa8c0@trws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206211617.14863.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 June 2002 16:03, Taavo Raykoff wrote:
> Can someone tell me what is going on here?
> <snip>
> hdparm settings appear to have no influence on this behavior.

Are you running DMA on these controllers? It looks like they're running PIO

Can you check the output of 'hdparm /dev/hd_' and "cat 
/proc/ide/hd_/settings"?
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

