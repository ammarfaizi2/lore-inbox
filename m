Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317328AbSFRFMm>; Tue, 18 Jun 2002 01:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSFRFMl>; Tue, 18 Jun 2002 01:12:41 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:61247 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S317325AbSFRFMk>; Tue, 18 Jun 2002 01:12:40 -0400
Date: Tue, 18 Jun 2002 01:12:42 -0400
From: Doug Ledford <dledford@redhat.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: Kurt Garloff <kurt@garloff.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020618011242.A7800@redhat.com>
Mail-Followup-To: Douglas Gilbert <dougg@torque.net>,
	Kurt Garloff <kurt@garloff.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <20020617180818.C30391@redhat.com> <20020617230648.GA3448@gum01m.etpnet.phys.tue.nl> <20020617224046.A6590@redhat.com> <3D0EB7D0.FDB66BAA@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D0EB7D0.FDB66BAA@torque.net>; from dougg@torque.net on Tue, Jun 18, 2002 at 12:32:16AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 12:32:16AM -0400, Douglas Gilbert wrote:
> As for "scsihosts" its current syntax is:
>  scsihosts=aic7xxx:sym53c8xx::aic7xxx
> 
> This could be extended to
>   scsihosts=aic7xxx[pci=00:0c.0]:sym53c8xx::aic7xxx
> and if "pci=" was assumed to be the default then this
> would have the same effect as:
>   scsihosts=[00:0c.0]:sym53c8xx::aic7xxx
> assuming there was a aic7xxx controlled HBA at that PCI slot.
> 
> No consistent persistence here, just a little more precision.

I think that relies upon the SCSI controller using the newer PCI scanning 
methods (which, for example, my aic7xxx driver does not use).

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
