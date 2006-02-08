Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWBHT4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWBHT4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWBHT4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:56:11 -0500
Received: from fmr21.intel.com ([143.183.121.13]:3011 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932491AbWBHT4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:56:10 -0500
Message-Id: <200602081955.k18Jtug12275@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jes Sorensen'" <jes@sgi.com>, "Alex Williamson" <alex.williamson@hp.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Adrian Bunk" <bunk@stusta.de>,
       "Keith Owens" <kaos@sgi.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [2.6 patch] let IA64_GENERIC select more stuff
Date: Wed, 8 Feb 2006 11:55:58 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYs5VZbZN8VZWpPRemOfGkgKlka/gAAx/1w
In-Reply-To: <43EA4557.6070107@sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote on Wednesday, February 08, 2006 11:24 AM
> > Seems like maybe PCI was removed so that it was possible to configure
> > a generic kernel to boot on the simulator...  I could imagine not having
> > PCI might have some degree of usefulness when using a ramdisk.  Isn't
> > this what the defconfigs are for?
> > That could explain it, but the question is whether one would want to
> 
> boot a generic kernel when running on a simulator. After all then every
> cycle does count ;)


CONFIG_IA64_GENERIC select CONFIG_ACPI, and CONFIG_ACPI select CONFIG_PCI,
This whole thread is silly since the beginning and it is a moot point for
all of previous discussions.  What are we talking about exactly??

- Ken

