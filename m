Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289871AbSBKRir>; Mon, 11 Feb 2002 12:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289874AbSBKRik>; Mon, 11 Feb 2002 12:38:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:16352 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289871AbSBKRiY>; Mon, 11 Feb 2002 12:38:24 -0500
Date: Mon, 11 Feb 2002 09:39:07 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Daniel Egger <degger@fhm.edu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance of Ingo's O(1) scheduler on NUMA-Q
Message-ID: <400310000.1013449147@flay>
In-Reply-To: <1013181364.31423.9.camel@sonja>
In-Reply-To: <Pine.LNX.4.33.0202080021520.7544-100000@localhost.localdomain> <1013181364.31423.9.camel@sonja>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Measuring kernel compile times on a 16 way NUMA-Q, adding Ingo's
>> > scheduler patch takes kernel compiles down from 47 seconds to 31
>> > seconds .... pretty impressive benefit.
>  
>> cool! By the way, could you try a test-compile with a 'big' .config file?
> 
> I'd assume that a 16way machine still taking 31s to compile the kernel
> is already having a 'big' config file. 

It's a fairly normal config file, but the machine isn't feeling very
in touch with it's NUMAness, so it scales badly. If I only use one
quad (4 processsors), the same compile takes 47s.

M.

