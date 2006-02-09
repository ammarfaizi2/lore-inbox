Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbWBIIxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbWBIIxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbWBIIxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:53:55 -0500
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:1929 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S965202AbWBIIxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:53:54 -0500
Date: Thu, 9 Feb 2006 09:53:44 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060209085344.GF16052@boogie.lpds.sztaki.hu>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org> <20060208165803.GA15239@kroah.com> <20060208170857.GA29818@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208170857.GA29818@srcf.ucam.org>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 05:08:58PM +0000, Matthew Garrett wrote:

> The backlight interface only supports exporting and setting the current 
> brightness. For various bits of hardware, the AC and DC brightnesses are 
> stored separately. Drivers would need to know which brightness value to 
> export to userspace. I have an HP backlight driver here which would 
> benefit from this, and I'm looking at the same issue for a Panasonic 
> one.

I don't know the backlight interface but extending it to export all
available brightness values would seem more logical to me.

If I'd had a laptop I'd hate if I could only set the DC brightness if I
plug out the AC power.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
