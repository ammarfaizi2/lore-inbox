Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967825AbWLEDvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967825AbWLEDvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 22:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968067AbWLEDvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 22:51:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:25000 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967825AbWLEDvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 22:51:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=owZ2ChfNeqYqh1ftfViLxFeWXBmyqTYQ9ZAnJ8ezSw9DZGKRfKCL/ht/jP9iQDzhY7Fd3T1ex3l+0OVmxl32lVjzp/WJZT6vRJSEOYRnhJXScVzyQdpPufXa4f7FQjS0bzSFaPMYX9ji6HoInxaR8hFnCx3MdsAkcoEF2eCLo5c=
Message-ID: <ac8af0be0612041951g6a41f5dfk5f9f09aa656f96e3@mail.gmail.com>
Date: Mon, 4 Dec 2006 19:51:09 -0800
From: "Zhao Forrest" <forrest.zhao@gmail.com>
To: dely.l.sy@intel.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Is there way to reserve more MMIO resource for PCIE-hotplug-capable slot?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sometimes we could hotplug a PCIE device, which require more MMIO
resource than that reserved by BIOS.

My question is: is there a way for kernel to reserved more MMIO
resource for a PCIE-hotplug-capable slot? I searched the
kernel-parameters.txt, but didn't find any related information.

Thanks,
Forrest
