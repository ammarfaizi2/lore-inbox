Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWCHXdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWCHXdz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWCHXdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:33:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751448AbWCHXdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:33:54 -0500
Date: Wed, 8 Mar 2006 15:30:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
In-Reply-To: <20060308231851.GA26666@suse.de>
Message-ID: <Pine.LNX.4.64.0603081528040.32577@g5.osdl.org>
References: <20060306223545.GA20885@kroah.com> <20060308222652.GR4006@stusta.de>
 <20060308225029.GA26117@suse.de> <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
 <20060308231851.GA26666@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Mar 2006, Greg KH wrote:
> 
> Understood.  Wait, what FC5 issues?  Andrew's problems?  Or something
> else?

Something else.

Although it might be related, since DaveJ reports that there are some 
weird bootup issues that come and go:

  "Fedora rawhide kernel stopped booting for a bunch of people, all with 
   686-SMP boxes. I saw it myself too, it hung just after the 'write 
   protecting kernel rodata'.

   It totally puzzled me for a day.  The following day, I rebased to 
   rc4-git4, and the problem "went away".  Nothing in the changesets 
   merged could explain the hangs I saw.

   A few days ago, the exact same bug resurfaced, and like before, the 
   following day, it went into hiding again."

I don't know a whole lot more. 

		Linus
