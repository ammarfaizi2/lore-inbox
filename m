Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVDHPVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVDHPVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 11:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVDHPVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 11:21:50 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:30935 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262839AbVDHPVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 11:21:48 -0400
In-Reply-To: <42569300.7070008@f2s.com>
References: <42569300.7070008@f2s.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <732461f28d4203394e841e2fd500c511@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: "Greg KH" <gregkh@suse.de>, <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: PATCH add support for system on chip (SoC) devices.
Date: Fri, 8 Apr 2005 10:21:25 -0500
To: "Ian Molton" <spyro@f2s.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 8, 2005, at 9:19 AM, Ian Molton wrote:

> Hi.
>
> This patch add support for a new 'System on Chip' or SoC bus type.
>
> This allows common drivers used in different SoC devices to be shared 
> in
> a clean and healthy manner, for example, the MMC function on toshiba
> t7l66xb, tc6393xb, and Compaq IPAQ ASIC3.
>
> This is in common use in the handhelds.org CVS tree.
>
> The only real issue is that drivers using this currently tend to assume
> that the SoC is attached to a platfrom_bus. This can be resolved as and
> when it becomes an issue for people.

What is wrong with using platform_device for this?  We have been doing 
that on PPC for SoCs for a few months now and I'm pretty sure ARM has 
been doing this even longer.

- kumar

