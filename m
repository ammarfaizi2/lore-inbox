Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268143AbTBYScT>; Tue, 25 Feb 2003 13:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbTBYScT>; Tue, 25 Feb 2003 13:32:19 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:30975 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268143AbTBYScR>;
	Tue, 25 Feb 2003 13:32:17 -0500
Message-ID: <3E5BB8C8.9040707@us.ibm.com>
Date: Tue, 25 Feb 2003 10:41:12 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Horrible L2 cache effects from kernel compile
References: <3E5BB7EE.5090301@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Dave, how many entries are in the dcache?

from slabinfo:
dentry_cache       35157  35352    160 1473 1473    1 :  248  124

The full result set:
http://www.sr71.net/prof/kernbench/run-kernbench-2.5.62.13/
-- 
Dave Hansen
haveblue@us.ibm.com

