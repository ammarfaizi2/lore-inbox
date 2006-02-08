Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWBHTYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWBHTYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWBHTYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:24:42 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:11682 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932488AbWBHTYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:24:41 -0500
Message-ID: <43EA4557.6070107@sgi.com>
Date: Wed, 08 Feb 2006 20:24:07 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@hp.com>
CC: "Luck, Tony" <tony.luck@intel.com>, Adrian Bunk <bunk@stusta.de>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
References: <B8E391BBE9FE384DAA4C5C003888BE6F05A6DEE7@scsmsx401.amr.corp.intel.com> <1139426479.26420.189.camel@localhost>
In-Reply-To: <1139426479.26420.189.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson wrote:
> On Wed, 2006-02-08 at 10:35 -0800, Luck, Tony wrote:
> 
> 
>>The current set looks close ... perhaps PCI should be added as it isn't
>>likely to inconvenience anyone, but SMP is a lot further into murky territory
> 
> 
>    Seems like maybe PCI was removed so that it was possible to configure
> a generic kernel to boot on the simulator...  I could imagine not having
> PCI might have some degree of usefulness when using a ramdisk.  Isn't
> this what the defconfigs are for?

Hi Alex,

That could explain it, but the question is whether one would want to
boot a generic kernel when running on a simulator. After all then every
cycle does count ;)

Anyway I think we're down nit picking in details. My vote is for
preserving status quo.

Cheers,
Jes
