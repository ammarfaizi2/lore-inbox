Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283048AbRLDLBq>; Tue, 4 Dec 2001 06:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283046AbRLDLBg>; Tue, 4 Dec 2001 06:01:36 -0500
Received: from zeus.kernel.org ([204.152.189.113]:38040 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S283061AbRLDLBW>;
	Tue, 4 Dec 2001 06:01:22 -0500
Date: Tue, 4 Dec 2001 10:59:19 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christoph Rohland <cr@sap.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Wrapping memory.
Message-ID: <20011204105919.B18147@flint.arm.linux.org.uk>
In-Reply-To: <20011204104047.A18147@flint.arm.linux.org.uk> <m3r8qcagt7.fsf@linux.local> <E16AIZ8-0008Re-00@the-village.bc.nu> <12969.1007315617@redhat.com> <m3r8qcagt7.fsf@linux.local> <25163.1007370678@redhat.com> <20011204104047.A18147@flint.arm.linux.org.uk> <7847.1007462704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7847.1007462704@redhat.com>; from dwmw2@infradead.org on Tue, Dec 04, 2001 at 10:45:04AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 10:45:04AM +0000, David Woodhouse wrote:
> Oooh. Can you do that without having phys->virt lookup?

Yep.  But only because we have page->mapping->i_mmap_shared.

> And what about mappings in other mms? Or are the ARM caches so broken
> that you have to flush the whole damn thing on mm switch anyway?
> VIVT. Urgh.

Correct. ;(

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

