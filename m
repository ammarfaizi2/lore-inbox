Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUHDXeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUHDXeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267510AbUHDXeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:34:46 -0400
Received: from palrel10.hp.com ([156.153.255.245]:64668 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S267507AbUHDXen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:34:43 -0400
Date: Wed, 4 Aug 2004 16:33:35 -0700
From: Grant Grundler <iod00d@hp.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-ia64@vger.kernel.org, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BROKEN PATCH] kexec for ia64
Message-ID: <20040804233335.GD548@cup.hp.com>
References: <200407261524.40804.jbarnes@engr.sgi.com> <200407261536.05133.jbarnes@engr.sgi.com> <20040730155504.2a51b1fa.rddunlap@osdl.org> <m18ycvhx1j.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18ycvhx1j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 07:07:04AM -0600, Eric W. Biederman wrote:
> Initially that patch
> was targeted for a kernel without device_shutdown(), so I was
> likely considering the old trick of running through all of the PCI
> devices and disabling their bus master bit.

Blindly disabling all PCI bus master bits will also kill VGA/serial
console and any USB keyboard attached to the system.

I'll comment more on the "DMA is a Red Herring" when I can read
more what it is about.

grant
