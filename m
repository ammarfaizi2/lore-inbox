Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVAILyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVAILyG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 06:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVAILyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 06:54:06 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:63494 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261183AbVAILyC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 06:54:02 -0500
Date: Sun, 9 Jan 2005 12:55:54 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Michal Feix <michal@feix.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Conflicts in kernel 2.6 headers and {glibc,Xorg}
Message-ID: <20050109115554.GA9183@irc.pl>
Mail-Followup-To: Michal Feix <michal@feix.cz>,
	linux-kernel@vger.kernel.org
References: <41E0F76D.7080805@feix.cz> <20050109110805.GA8688@irc.pl> <41E1170D.6090405@feix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E1170D.6090405@feix.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 12:35:41PM +0100, Michal Feix wrote:
> > Are you using proper kernel headers - from
> >http://ep09.pld-linux.org/~mmazur/linux-libc-headers/ ?
> 
> No, I am not, because I wasn't told to do so. For meny years I always 
> used vanilla sources from kernel.org for my /usr/include/... I wasn't 
> told, that it is wrong and I still believe, that Linux kernel headers 
> should be fixed by including these conflicting macros and functions into 
> __KERNEL__ block instead. Or am I missing something?

 According to Linus, using straight kernel headers for /usr/include
is obsolete for 10 (ten) years now. I do not agree, but kernel
developers do.
 There was few discussion on this topic. Here's one Linus post:
http://www.ussg.iu.edu/hypermail/linux/kernel/0007.3/0587.html
 Here you can find latest thread about fixing this issue:
http://lkml.org/lkml/2004/11/26/106

 Mainstream distributions use ,,sanitized'' version o kernel
headers - Fedora has own set, Debian has another,  LFS too. For rest and
for us, casual users, there are headers made as byproduct of PLD
Linux, which are used since december 2003 (before kernel 2.6 was
even released).

 Cheers,
-- 
Tomasz Torcz                Only gods can safely risk perfection,
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia

