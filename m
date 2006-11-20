Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933840AbWKTB2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933840AbWKTB2u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 20:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933842AbWKTB2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 20:28:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:37477 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S933840AbWKTB2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 20:28:50 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,439,1157353200"; 
   d="scan'208"; a="164019903:sNHT18058306"
Date: Sun, 19 Nov 2006 17:04:58 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
Subject: Re: [patch] Export Last Level Cache topology to userspace
Message-ID: <20061119170458.A11031@unix-os.sc.intel.com>
References: <1163934920.31358.494.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1163934920.31358.494.camel@laptopd505.fenrus.org>; from arjan@linux.intel.com on Sun, Nov 19, 2006 at 12:15:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 12:15:20PM +0100, Arjan van de Ven wrote:
> right now the sysfs topology information exports things like sibling
> maps (which cpu is a hyperthreading peer of another) and which "linux
> cpus" share the physical package. The patch below adds a bitmap in the
> same style that exports which "linux cpus" share the last level cache.

Arjan, This info is already exported today through

/sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_map

thanks,
suresh
