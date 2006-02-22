Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbWBVSAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWBVSAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbWBVSAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:00:22 -0500
Received: from mail.gmx.de ([213.165.64.20]:28313 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161209AbWBVSAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:00:21 -0500
X-Authenticated: #428038
Date: Wed, 22 Feb 2006 19:00:15 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Douglas Gilbert <dougg@torque.net>,
       Matthias Andree <matthias.andree@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: lsscsi-0.17 released
Message-ID: <20060222180015.GB20880@merlin.emma.line.org>
Mail-Followup-To: Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
	Douglas Gilbert <dougg@torque.net>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <43FBA4CD.6000505@torque.net> <m34q2r93q2.fsf@merlin.emma.line.org> <43FC7CCB.4090508@torque.net> <20060222160602.GB17473@merlin.emma.line.org> <43FC90E4.10805@torque.net> <20060222163426.GG28587@parisc-linux.org> <20060222171438.GA20272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222171438.GA20272@kroah.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Greg KH wrote:

> It was changed as there would be more than one "block" symlink in a
> device's directory if more than one block device was attached to a
> single struct device.  For example, ub and multi-lun devices (there were
> other reports of this happening for scsi devices too at the time from
> what I remember.)

OK, just post an announcement to l-k when sysfs has stabilized enough to
be worth bothering.

-- 
Matthias Andree
