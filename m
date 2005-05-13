Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVEMXw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVEMXw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVEMXvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:51:11 -0400
Received: from terminus.zytor.com ([209.128.68.124]:34724 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262595AbVEMXtb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:49:31 -0400
Message-ID: <42853CFC.3080506@zytor.com>
Date: Fri, 13 May 2005 16:49:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86
 MTRR handling
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com> <42852CE2.4090102@zytor.com> <20050513232357.GB13846@redhat.com> <428539EA.7000406@zytor.com> <20050513234211.GF13846@redhat.com>
In-Reply-To: <20050513234211.GF13846@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, May 13, 2005 at 04:36:10PM -0700, H. Peter Anvin wrote:
> 
>  > The Efficeon (TM8xxx) series does have PAT.
> 
> 1:1 with the Intel implementation I assume based on your earlier comments?

More or less.  They don't implement WT and WP (defaulting to WB with 
full cache coherency and something else).

	-hpa
