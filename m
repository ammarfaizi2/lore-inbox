Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbTBTFEN>; Thu, 20 Feb 2003 00:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbTBTFEM>; Thu, 20 Feb 2003 00:04:12 -0500
Received: from franka.aracnet.com ([216.99.193.44]:5763 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264867AbTBTFEM>; Thu, 20 Feb 2003 00:04:12 -0500
Date: Wed, 19 Feb 2003 21:14:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: Performance of partial object-based rmap
Message-ID: <32200000.1045718048@[10.10.2.4]>
In-Reply-To: <20030220044748.GE22687@holomorphy.com>
References: <7490000.1045715152@[10.10.2.4]> <20030220044748.GE22687@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Profile comparison:
>> before
>> 	15525 page_remove_rmap
>> 	6415 page_add_rmap
>> after
>> 	2055 page_add_rmap
>> 	1983 page_remove_rmap
> 
> Could I get a larger, multiplicative differential profile?
> i.e. ratios of the fractions of profile hits?
> 
> If you have trouble generating such I can do so myself from
> fuller profile results.

before:
	187256 total
after:
	170196 total

M.


