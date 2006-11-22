Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161963AbWKVIul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161963AbWKVIul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031238AbWKVIul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:50:41 -0500
Received: from mga06.intel.com ([134.134.136.21]:57897 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1031152AbWKVIuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:50:40 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,447,1157353200"; 
   d="scan'208"; a="165328095:sNHT274748642"
Message-ID: <45640F56.5040509@linux.intel.com>
Date: Wed, 22 Nov 2006 09:50:30 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Add do_not_call_when_idle option to timer and workqueue
References: <20061121162845.A24791@unix-os.sc.intel.com> <20061121181114.b9d923bd.akpm@osdl.org> <4563F05C.4090809@argo.co.il>
In-Reply-To: <4563F05C.4090809@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> The lsb of a function pointer is used in variable length instruction 
> processors (such as x86 when optimizing for size).  The msb is constant 
> though.
> 

x86 aligns the start of functions to 4 bytes even when optimizing for 
size though...
