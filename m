Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWEYAiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWEYAiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWEYAiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:38:50 -0400
Received: from mga06.intel.com ([134.134.136.21]:42937 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S964797AbWEYAiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:38:50 -0400
X-IronPort-AV: i="4.05,170,1146466800"; 
   d="scan'208"; a="40992629:sNHT28211092"
Date: Wed, 24 May 2006 17:36:39 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       y-goto@jp.fujitsu.com, ktokunag@redhat.com, akpm@osdl.org
Subject: Re: [RFC][PATCH] node hotplug : register_cpu() changes [0/3]
Message-ID: <20060524173639.A2506@unix-os.sc.intel.com>
References: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com> <20060523075202.A24516@unix-os.sc.intel.com> <20060524091816.5a3960b9.kamezawa.hiroyu@jp.fujitsu.com> <20060524075128.A32074@unix-os.sc.intel.com> <20060525093418.b1639de2.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060525093418.b1639de2.kamezawa.hiroyu@jp.fujitsu.com>; from kamezawa.hiroyu@jp.fujitsu.com on Thu, May 25, 2006 at 09:34:18AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 09:34:18AM +0900, KAMEZAWA Hiroyuki wrote:
> 
> Currently, I think  creating new empty node (pgdat) at onlining can work.
> by cpu hotplug notifier chain, dangling cpus will create new pgdat.
> If people want to see node <-> cpu relationship before onlining cpu, I' ll have
> to do complicated work.
> 


Iam ok with this patch, no need to get anything complicated without good 
reason.

Just want to make sure assumptions for cpu only nodes are not broken, as long
as we have your implementation take care of those, this is good.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
