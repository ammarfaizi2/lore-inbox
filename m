Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbWALQ3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWALQ3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWALQ3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:29:37 -0500
Received: from arava.co.il ([212.29.226.3]:6357 "HELO arava.co.il")
	by vger.kernel.org with SMTP id S1030466AbWALQ3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:29:36 -0500
Date: Thu, 12 Jan 2006 18:29:33 +0200 (IST)
From: Matan Ziv-Av <matan@svgalib.org>
X-X-Sender: matan@matan.home
To: "Rajeev V. Pillai" <rajeevvp@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Removal of PCI_VENDOR_ID_RENDITION from 2.6.15
In-Reply-To: <Pine.LNX.4.64.0601120752320.1259@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0601121826010.3880@matan.home>
References: <Pine.LNX.4.64.0601120752320.1259@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006, Rajeev V. Pillai wrote:

> Why were the RENDITION related PCI Vendor and device IDs removed from
> 2.6.15?  Svgalib, for one, depends on it.

For svgalib, this did not matter, since there is another issue with 
kernel 2.6.15 (increasing number of parameters of 
class_device_create()).

I posted a patch for the kernel module at:
http://groups.googlegroups.com/group/svgalib/browse_thread/thread/dbca938113f5c1cc


-- 
Matan Ziv-Av.                         matan@svgalib.org

