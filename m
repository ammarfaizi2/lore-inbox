Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVKCPCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVKCPCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVKCPCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:02:46 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:23794 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030246AbVKCPCq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:02:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tlrQwc/iKd7AzLVuYxew8CS8ONv54vUi8r0ttvZxzbMmB0nBE4KwT+4gIFI9t0v01npdj1EgWJJBXXpVMOihfQaxmVSdSWvCbgRZdXyWU/tJ4v8crOvb65I0hqHRi/Om/iRpRVcBrPysfwYTLSi3iJ+ACrydoXTDBww3k1wn99g=
Message-ID: <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
Date: Thu, 3 Nov 2005 16:02:45 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Parallel ATA with libata status with the patches I'm working on
In-Reply-To: <20051103144830.GF28038@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Nov 03, 2005 at 02:54:46PM +0000, Alan Cox wrote:
> > AEC62xx
> > ATIIXP
> > CMD64x
> > CY82C693
> > IT8172
> > NS87415
> > OPTI621
> > PDC202xx
> > SGI IOC4
> > SIS5513
> > SL82C105
> > SLC90E66
> > TRM290
> > PCMCIA (needs hotplug merge first)
>
> + icside ?

pmac
rapide
bast-ide
ide_arm
ide-cris
ide-h8300
mpc8xx
legacy stuff (optional?)...

IMO porting/rewriting host-drivers to libata now is just
counter-productive waste of time...

Bartlomiej
