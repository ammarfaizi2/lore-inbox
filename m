Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263790AbUF0QWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbUF0QWt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 12:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUF0QWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 12:22:49 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53696 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263790AbUF0QWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 12:22:48 -0400
Date: Sun, 27 Jun 2004 12:22:02 -0400
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Assuming someone else called the IRQ
Message-ID: <20040627162202.GC6253@ruslug.rutgers.edu>
References: <200406261808.31860.s0348365@sms.ed.ac.uk> <20040626181552.C30532@flint.arm.linux.org.uk> <200406261839.39274.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406261839.39274.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 06:39:39PM +0100, Alistair John Strachan wrote:
> On Saturday 26 June 2004 18:15, Russell King wrote:
> > On Sat, Jun 26, 2004 at 06:08:31PM +0100, Alistair John Strachan wrote:
> > drivers/net/wireless/prism54/islpci_dev.c:
> > 	printk(KERN_DEBUG "Assuming someone else called the IRQ\n");
> 
> Luis, could you please look into removing this message from the sources. It 
> causes my kernel ring buffer to be wiped fairly quickly, which is annoying 
> for debugging development kernels.

Will do on my next patch, next time just e-mail netdev, cc prism54-devel. 

	Luis
-- 
GnuPG Key fingerprint = 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E
