Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbVLGWmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbVLGWmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbVLGWmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:42:16 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:31254 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751825AbVLGWmP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:42:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mtft7aRNkIjWCAoFDZ7ib0yd4w0h69EHh519TwnF+R3zu/OVY23qcsv17PmHMfQ54BW2UVC0sxxB5PXoFPdBBIABSIwtxtXLhhh/33QQ4SCW/9xiH04g9Z4++KY6jZO1QhptlOpfVYrSxJ0YW3JBueAZzq+rwlqrTEgcK213rko=
Message-ID: <58cb370e0512071442j7ed609cev1a4a27dc30e43af8@mail.gmail.com>
Date: Wed, 7 Dec 2005 23:42:13 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Cc: Shaohua Li <shaohua.li@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>,
       linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
In-Reply-To: <1133994916.544.102.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
	 <1133970074.544.69.camel@localhost.localdomain>
	 <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com>
	 <1133918523.2936.12.camel@sli10-mobl.sh.intel.com>
	 <58cb370e0512071115i3dbb741aqda7f98a97221d99b@mail.gmail.com>
	 <1133994916.544.102.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-12-07 at 20:15 +0100, Bartlomiej Zolnierkiewicz wrote:
> > PS1 Please don't use taskfile_lib_get_identify(), drive->id
> > should contain valid ID - if it doesn't it is a BUG.
>
> If someone swapped the drive while suspended that isnt true. OTOH I'm
> not sure what the hell you'd do if that was the case and you are using
> drivers/ide right now.

This is unsupported anyway so doesn't matter for IDE ACPI support...
