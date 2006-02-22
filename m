Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWBVQGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWBVQGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWBVQGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:06:10 -0500
Received: from mail.gmx.de ([213.165.64.20]:33928 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932276AbWBVQGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:06:07 -0500
X-Authenticated: #428038
Date: Wed, 22 Feb 2006 17:06:02 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lsscsi-0.17 released
Message-ID: <20060222160602.GB17473@merlin.emma.line.org>
Mail-Followup-To: Douglas Gilbert <dougg@torque.net>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <43FBA4CD.6000505@torque.net> <m34q2r93q2.fsf@merlin.emma.line.org> <43FC7CCB.4090508@torque.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC7CCB.4090508@torque.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Douglas Gilbert wrote:

> Matthias Andree wrote:

> > Does this work around new incompatibilities in the kernel
> > or does this fix lsscsi bugs?
> 
> The former. In lk 2.6.16-rc1 the
> /sys/class/scsi_device/<hcil>/device/block symlink
> changed to ".../block:sd<x>" breaking lsscsi 0.16 (and
> earlier) and sg_map26 (in sg3_utils).

Heck, what was the reason for breaking userspace again?

Why would someone even consider using sysfs at all if it changes
incompatibly?

-- 
Matthias Andree
