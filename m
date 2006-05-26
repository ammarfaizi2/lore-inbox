Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWEZKzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWEZKzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWEZKzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:55:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:48871 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932193AbWEZKzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:55:32 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: Recent x86-64 patch causes many devices to disappear
Date: Fri, 26 May 2006 12:55:26 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       gregkh@suse.de, trenn@suse.de,
       joachim deguara <joachim.deguara@amd.com>
References: <4476D020.8070605@garzik.org> <200605261203.55108.ak@suse.de> <4476D874.6060000@garzik.org>
In-Reply-To: <4476D874.6060000@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261255.27471.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 12:29, Jeff Garzik wrote:
> Andi Kleen wrote:
> > The problem is that most people cannot figure out how 
> > to disable this in the BIOS so we needed a way to make it boot
> > out of the box.
> 
> Agreed.

Do you use SCSI on your box? According to Joachim booting with 
segmentation on and not pci=noacpi SCSI is not seen. And that's the 
default setup on the machine which made it unusable.

> 
> 
> > Booting without PCI-X is better than booting with it.
> 
> May I suppose you mean "booting without PCI-X is better than not booting 
> at all" ?  Booting with PCI-X is obviously better.

Yes.


-Andi
