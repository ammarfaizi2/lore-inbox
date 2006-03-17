Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWCQSLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWCQSLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWCQSLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:11:06 -0500
Received: from mail.linicks.net ([217.204.244.146]:8069 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1030247AbWCQSLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:11:05 -0500
From: Nick Warne <nick@linicks.net>
To: "Felipe Alfaro Solana" <felipe.alfaro@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: chmod 111
Date: Fri, 17 Mar 2006 18:11:01 +0000
User-Agent: KMail/1.9.1
References: <200603171746.18894.nick@linicks.net> <6f6293f10603171007vbf752e5n8a3d6f2d65e0a1e7@mail.gmail.com>
In-Reply-To: <6f6293f10603171007vbf752e5n8a3d6f2d65e0a1e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171811.01963.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 18:07, Felipe Alfaro Solana wrote:
> > I shouldn't be able to execute 'ls' as I can't read it, shouldn't it?
>
> Nop... you can execute binaries even if the read permission is not
> granted. Note that I said "binaries". Shell script files need read and
> execute permission, since they must be read by a shell interpreter in
> order to get executed.

Hi Felipe,

First, apologies as this isn't kernel issue (but related, I suppose).

Yes, I see now after much messing about.  Why then are most binaries chmod 
755?  Who would need (why) to read a [system] binary?

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
