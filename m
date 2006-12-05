Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756305AbWLEXuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbWLEXuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756952AbWLEXuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:50:16 -0500
Received: from terminus.zytor.com ([192.83.249.54]:51225 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756305AbWLEXuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:50:14 -0500
Message-ID: <457605A5.1060401@zytor.com>
Date: Tue, 05 Dec 2006 15:49:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Zhao Forrest <forrest.zhao@gmail.com>
CC: dely.l.sy@intel.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Is there way to reserve more MMIO resource for PCIE-hotplug-capable
 slot?
References: <ac8af0be0612041951g6a41f5dfk5f9f09aa656f96e3@mail.gmail.com>
In-Reply-To: <ac8af0be0612041951g6a41f5dfk5f9f09aa656f96e3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhao Forrest wrote:
> Hi,
> 
> Sometimes we could hotplug a PCIE device, which require more MMIO
> resource than that reserved by BIOS.
> 
> My question is: is there a way for kernel to reserved more MMIO
> resource for a PCIE-hotplug-capable slot? I searched the
> kernel-parameters.txt, but didn't find any related information.
> 

If you need 32-bit MMIO, no, because it requires chipset-specific 
reprogramming.  64-bit MMIO should be readily available.

	-hpa
