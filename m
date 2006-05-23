Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWEWFoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWEWFoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 01:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWEWFoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 01:44:22 -0400
Received: from mga07.intel.com ([143.182.124.22]:56891 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932072AbWEWFoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 01:44:21 -0400
X-IronPort-AV: i="4.05,159,1146466800"; 
   d="scan'208"; a="40190907:sNHT2315605159"
Date: Mon, 22 May 2006 22:42:23 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, jacob.shin@amd.com,
       akpm@osdl.org
Subject: Re: cpu hotplug sleeping from invalid context
Message-ID: <20060522224222.A21335@unix-os.sc.intel.com>
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

I was just purging my inbox this morning, and saw a similar report from 
Jacob Shin in the x86-64 discuss list. When i checked with him, he replied 
that this is now resolved. I didnt ask what it was... Jacob could you 
send a pointer to the fix?

Cheers,
ashok
