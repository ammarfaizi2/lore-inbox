Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVLPSfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVLPSfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVLPSfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:35:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21418 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932366AbVLPSfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:35:36 -0500
Date: Fri, 16 Dec 2005 13:35:23 -0500
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: documentation fixes
Message-ID: <20051216183523.GF2821@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20051216105852.GJ8476@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216105852.GJ8476@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 11:58:52AM +0100, Pavel Machek wrote:

 > +Q: How can RH ship a swsusp-supporting kernel with modular SATA
 > +drivers?
 >  
 > +A: Well, it can be done, load the drivers, then do echo into resume
 > +file from initrd. Be sure not to mount anything, not even read-only
 > +mount, or you are going to loose your filesystem same way Dave Jones
 > +did.

I don't need the fame here thanks.
I've hit a thousand other ways to corrupt my rootfs, I don't think
it's worth documenting them.  It's arguable this whole item is needed
to be documented, but if you feel compelled to write Red Hat specific
documentation in the swsusp docs, feel free to note that
'make modules_install ; make install' just does the right thing,
including building an initrd for you with all the right pieces.

		Dave

