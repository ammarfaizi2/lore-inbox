Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUHSS3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUHSS3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUHSS3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:29:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:39837 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267186AbUHSS3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:29:05 -0400
Date: Thu, 19 Aug 2004 11:25:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>, davidm@hpl.hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: kernbench on 512p
Message-ID: <253460000.1092939952@flay>
In-Reply-To: <200408191237.16959.jbarnes@engr.sgi.com>
References: <200408191216.33667.jbarnes@engr.sgi.com> <16676.54657.220755.148837@napali.hpl.hp.com> <200408191237.16959.jbarnes@engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday, August 19, 2004 12:29 pm, David Mosberger wrote:
>> >>>>> On Thu, 19 Aug 2004 12:16:33 -0400, Jesse Barnes
>> >>>>> <jbarnes@engr.sgi.com> said:
>> 
>>   Jesse> It would be nice if the patch to show which lock is contended
>>   Jesse> got included.
>> 
>> Why not use q-syscollect?  It will show you the caller of
>> ia64_spinlock_contention, which is often just as good (or better ;-).
> 
> Because it requires guile and guile SLIB, which I've never been able to setup 
> properly on a RHEL3 based distro.  Care to rewrite the tools in C or 
> something? ;)

Does lockmeter not work for you? It's sitting in my tree still, and 
Andrew's last time I looked.

M.

