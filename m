Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVHTWRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVHTWRv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 18:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVHTWRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 18:17:51 -0400
Received: from mail.linicks.net ([217.204.244.146]:37382 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750716AbVHTWRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 18:17:51 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: RTL8139, the final patch ?
Date: Sat, 20 Aug 2005 23:17:46 +0100
User-Agent: KMail/1.8.1
References: <200508202153.17837.nick@linicks.net>
In-Reply-To: <200508202153.17837.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508202317.46937.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 August 2005 21:53, you wrote:
> I have a problem with it:
> It's about patching, reverting, patching, reverting,...
> I got lost. That's why I asked for a... "straighter" one :-)

>> But I looked at what he said and found the real problem on my system (after 
>> all that):
>> http://www.ussg.iu.edu/hypermail/linux/kernel/0403.1/1537.html

> It's about a configuration option in the kernel?
> The patch is about adding the option, if i'm right.

No, what happened was on 2.6.2 all was well.  When 2.6.3 came out I got these 
timeout errors on the NIC's - but using the 2.6.2 8139too.c file in 2.6.3 
worked.  Mr Hirofumi then took up the challenge and sent me patches.  Slowly 
he resolved the issue, but the conclusion was it wasn't the code causing it.

It was an option in my BIOS PCI level/edge settings as I posted.  People on 
laptops get this error, like you, but there is no BIOS option as such... :-/

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
