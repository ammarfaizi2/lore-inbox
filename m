Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWEWF6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWEWF6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 01:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWEWF6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 01:58:53 -0400
Received: from mga05.intel.com ([192.55.52.89]:24840 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932083AbWEWF6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 01:58:52 -0400
X-IronPort-AV: i="4.05,159,1146466800"; 
   d="scan'208"; a="41068582:sNHT2074668071"
Date: Mon, 22 May 2006 22:56:52 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       jacob.shin@amd.com
Subject: Re: cpu hotplug sleeping from invalid context
Message-ID: <20060522225652.A21377@unix-os.sc.intel.com>
References: <20060522183534.GA8920@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060522183534.GA8920@redhat.com>; from davej@redhat.com on Mon, May 22, 2006 at 11:35:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 11:35:34AM -0700, Dave Jones wrote:
> 
>    (2.6.17rc4-git9)
> 
>    echo 0 > /sys/devices/system/cpu/cpu1/online
>    echo 1 > /sys/devices/system/cpu/cpu1/online
> 
>    on my dual-core notebook gets me this:
> 

Ok, i just tried on my Centrino core duo, and the same online/offline
works just fine for me on git-10. I havent tried git-9 though... could you 
give git10 a try?

ashok
