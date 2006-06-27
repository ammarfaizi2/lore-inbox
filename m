Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161261AbWF0Rll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161261AbWF0Rll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbWF0Rlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:41:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:50822 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161261AbWF0Rlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:41:40 -0400
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc and what's the next step?
Date: Tue, 27 Jun 2006 19:40:46 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       klibc@zytor.com, torvalds@osdl.org
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <p73r71attww.fsf@verdi.suse.de> <44A166AF.1040205@zytor.com>
In-Reply-To: <44A166AF.1040205@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606271940.46634.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 June 2006 19:11, H. Peter Anvin wrote:
> Andi Kleen wrote:
> > Jeff Garzik <jeff@garzik.org> writes:
> >> MD/DM root setup,
> > 
> > That would require pulling the tools for that into the kernel source right?
> > Not sure that's a good idea. Do you really want /usr/src/linux/liblvm ? 
> > 
> 
> Only enough to bring up the filesystem.  This is, of course, already the 
> case for MD.  That code has (mostly) not yet been moved to userspace, 
> but that is definitely on the road map going forward.

But not for LVM where this can be fairly complex.

And next would be probably iSCSI. Maybe it's better to leave some stuff
in initramfs. 

-Andi
