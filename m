Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTLEWKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTLEWKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:10:53 -0500
Received: from codepoet.org ([166.70.99.138]:31915 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S264326AbTLEWKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:10:51 -0500
Date: Fri, 5 Dec 2003 15:10:51 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Torsten Scheck <torsten.scheck@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-FAT32-Filesystem Bug
Message-ID: <20031205221051.GA3244@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Torsten Scheck <torsten.scheck@gmx.de>, linux-kernel@vger.kernel.org
References: <3FD0555F.5060608@gmx.de> <20031205160746.GA18568@codepoet.org> <3FD0C64D.5050804@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD0C64D.5050804@gmx.de>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 05, 2003 at 06:54:21PM +0100, Torsten Scheck wrote:
> Erik Andersen wrote:
> >Does this help?
> >
> > -Erik
> 
> [... int=>loff_t ino,inum-patch ...]
> 
> Hi Erik:
> 
> I applied your patch to 2.4.23 and it solved the problem. No more lost 
> clusters. All data stays where it belongs.
> 
> I'll test it for a few days and get back to you later.
> 
> Thank you very much.

No problem.  I put this patch together quite a while ago for
my own use and never got around to sending it in.  It removes
a number of artificial fat32 limits, and allows files up to 4GB,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
