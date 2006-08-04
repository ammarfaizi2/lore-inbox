Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161237AbWHDOqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbWHDOqF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161240AbWHDOqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:46:04 -0400
Received: from mga07.intel.com ([143.182.124.22]:39693 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161237AbWHDOqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:46:03 -0400
X-IronPort-AV: i="4.07,211,1151910000"; 
   d="scan'208"; a="97745748:sNHT10335812774"
Message-ID: <44D35D99.601@linux.intel.com>
Date: Fri, 04 Aug 2006 07:45:45 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Greg Banks <gnb@melbourne.sgi.com>
CC: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2 of 4] cpumask: export cpu_online_map and cpu_possible_map
 consistently
References: <1154669759.21040.2353.camel@hole.melbourne.sgi.com>
In-Reply-To: <1154669759.21040.2353.camel@hole.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Banks wrote:
> cpumask: ensure that the cpu_online_map and cpu_possible_map bitmasks,
> and hence all the macros in <linux/cpumask.h> that require them, are
> available to modules for all supported combinations of architecture
> and CONFIG_SMP.

Are there any actual users of this?
