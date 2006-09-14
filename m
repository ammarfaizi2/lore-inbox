Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWINRbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWINRbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWINRbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:31:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:46777 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1750716AbWINRbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:31:23 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,165,1157353200"; 
   d="scan'208"; a="127025341:sNHT2479911875"
Message-ID: <45099095.3020303@intel.com>
Date: Thu, 14 Sep 2006 10:25:41 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: David Singleton <daviado@gmail.com>
CC: Greg KH <greg@kroah.com>, linux-pm@lists.osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: OpPoint summary
References: <20060911082025.GD1898@elf.ucw.cz>	 <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>	 <20060911225617.GB13474@elf.ucw.cz>	 <20060912001701.GC14234@linux.intel.com>	 <20060912033700.GD27397@kroah.com>	 <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>	 <20060914055529.GA18031@kroah.com> <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
In-Reply-To: <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2006 17:27:27.0449 (UTC) FILETIME=[0CA8EC90:01C6D823]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Singleton wrote:

> +static const struct cpu_id cpu_ids[] = {
> +       [CPU_BANIAS]    = { 6,  9, 5 },
> +       [CPU_DOTHAN_A1] = { 6, 13, 1 },
> +       [CPU_DOTHAN_A2] = { 6, 13, 2 },
> +       [CPU_DOTHAN_B0] = { 6, 13, 6 },
> +       [CPU_MP4HT_D0]  = {15,  3, 4 },
> +       [CPU_MP4HT_E0]  = {15,  4, 1 },
> +};


Any reason why { 6, 13, 8 } is missing? My lenovo T43 identifies itself as such:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.86GHz
stepping        : 8

I'm not sure a Dothan B1 exists, but some postings suggest even C0 and C1 are 
valid steppings. I'm sure OpPoint could work with those as well.

Auke
