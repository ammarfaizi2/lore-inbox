Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318080AbSHPCmT>; Thu, 15 Aug 2002 22:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSHPCmT>; Thu, 15 Aug 2002 22:42:19 -0400
Received: from holomorphy.com ([66.224.33.161]:20413 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318080AbSHPCmS>;
	Thu, 15 Aug 2002 22:42:18 -0400
Date: Thu, 15 Aug 2002 19:44:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 kmap_atomic copy_*_user benefits
Message-ID: <20020816024436.GX15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20020815232126.GR15685@holomorphy.com> <3D5C5F05.7080004@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D5C5F05.7080004@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> With and without kmap_atomic() -based copy_*_user() patches from akpm.
>> Taken on a 16x/16GB box.

On Thu, Aug 15, 2002 at 07:10:13PM -0700, Dave Hansen wrote:
> Have you seen any instability with these things applied?  I seem to be 
> getting a fair amount of these BUG()s.  But, I imagine that it could 
> be a race uncovered because of the serialization that highmem locks 
> caused.
> kernel BUG at softirq.c:229!
> invalid operand: 0000

Hmm, I didn't catch this one. OTOH I did use a fwd port of an earlier
version of the patch. Shall we kgdb? Which box/workload?


Cheers,
Bill
