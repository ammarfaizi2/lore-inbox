Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030545AbWBHTVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030545AbWBHTVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWBHTVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:21:21 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:42192 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932482AbWBHTVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:21:20 -0500
Subject: RE: [2.6 patch] let IA64_GENERIC select more stuff
From: Alex Williamson <alex.williamson@hp.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Jes Sorensen <jes@sgi.com>, Adrian Bunk <bunk@stusta.de>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F05A6DEE7@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05A6DEE7@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Organization: LOSL
Date: Wed, 08 Feb 2006 12:21:19 -0700
Message-Id: <1139426479.26420.189.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 10:35 -0800, Luck, Tony wrote:

> The current set looks close ... perhaps PCI should be added as it isn't
> likely to inconvenience anyone, but SMP is a lot further into murky territory

   Seems like maybe PCI was removed so that it was possible to configure
a generic kernel to boot on the simulator...  I could imagine not having
PCI might have some degree of usefulness when using a ramdisk.  Isn't
this what the defconfigs are for?

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

