Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264799AbUETBGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264799AbUETBGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 21:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264818AbUETBGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 21:06:18 -0400
Received: from [213.171.41.46] ([213.171.41.46]:28439 "EHLO
	kaamos.homelinux.net") by vger.kernel.org with ESMTP
	id S264799AbUETBGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 21:06:14 -0400
From: Alexey Kopytov <alexeyk@mysql.com>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
Date: Thu, 20 May 2004 05:06:02 +0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
References: <200405022357.59415.alexeyk@mysql.com> <1084480888.22208.26.camel@dyn319386.beaverton.ibm.com> <1084815010.13559.3.camel@localhost.localdomain>
In-Reply-To: <1084815010.13559.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Organization: MySQL AB
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200405200506.03006.alexeyk@mysql.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai wrote:

>Attached the cleaned up patch and the performance results of the patch.
>
>Overall Observation:
>        1.Small improvement with iozone with the patch, and overall
>                        much better performance than 2.4
>        2.Small/neglegible improvement with DSS workload.
>        3.Negligible impact with sysbench, but results worser than
>                        2.4 kernels

Ram, can you clarify the status of this patch please?

I ran the same sysbench test on my hardware with patched 2.6.6 and got 
122.2348s execution time, i.e. almost the same results as in the original 
tests. Is this patch an intermediate step to improve the sysbench workload on 
2.6, or it just addresses another problem?

-- 
Alexey Kopytov, Software Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification
