Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754322AbWKHFp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322AbWKHFp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbWKHFp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:45:59 -0500
Received: from mga07.intel.com ([143.182.124.22]:56456 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1754321AbWKHFp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:45:58 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,399,1157353200"; 
   d="scan'208"; a="142841858:sNHT19343807"
Date: Tue, 7 Nov 2006 21:23:32 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, ak@suse.de,
       shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com
Subject: Re: [patch 2/4] introduce the mechanism of disabling cpu hotplug control
Message-ID: <20061107212332.A6418@unix-os.sc.intel.com>
References: <20061107173306.C3262@unix-os.sc.intel.com> <20061107173624.A5401@unix-os.sc.intel.com> <20061107174024.B5401@unix-os.sc.intel.com> <20061107195430.37f8deb0.akpm@osdl.org> <20061107200133.A5933@unix-os.sc.intel.com> <20061107203504.b8e17ea8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061107203504.b8e17ea8.akpm@osdl.org>; from akpm@osdl.org on Tue, Nov 07, 2006 at 08:35:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 08:35:04PM -0800, Andrew Morton wrote:
> On Tue, 7 Nov 2006 20:01:34 -0800
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> 
> > I wanted to add something like disable_cpu_hotplug
> 
> My point is, `enable_cpu_hotplug' is nicer

Yep. I got it and hence my "will clean this up" assurance :)

This is all coming from the `no_control' member in cpu structure and I will
change that to something like `hotpluggable'. That will make the patch slightly
big but def clean.

thanks,
suresh
