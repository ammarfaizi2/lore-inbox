Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268734AbUIMQRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268734AbUIMQRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIMQN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:13:29 -0400
Received: from jade.spiritone.com ([216.99.193.136]:55505 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267165AbUIMQLj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:11:39 -0400
Date: Mon, 13 Sep 2004 09:11:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, colpatch@us.ibm.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <732210000.1095091880@[10.10.2.4]>
In-Reply-To: <20040913081841.6689d34c.pj@sgi.com>
References: <20040913015003.5406abae.akpm@osdl.org><650660000.1095088173@[10.10.2.4]> <20040913081841.6689d34c.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Paul Jackson <pj@sgi.com> wrote (on Monday, September 13, 2004 08:18:41 -0700):

> Martin wrote:
>> The NUMA one is either cpusets-big-numa-cpu-and-memory-placement.patch
>> or create-nodemask_t.patch by the looks of it
> 
> The numa one, with the following errors:
> 
>   mm/mempolicy.c: In function `get_zonemask':
>   mm/mempolicy.c:419: error: `maxnode' undeclared (first use in this function)
> 
> is due to fix-abi-in-set_mempolicy.patch.
> 
> See my fix on lkml:
> 
>   Subject: [PATCH] undo more numa maxnode confusions
>   Date: Mon, 13 Sep 2004 05:58:48 -0700

That worked - thanks.

The others seem only to be warnings, and are allegedly no worse than before,
so maybe it'll work now ;-)

M.

