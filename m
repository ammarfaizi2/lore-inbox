Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268883AbTCCXbA>; Mon, 3 Mar 2003 18:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268885AbTCCXbA>; Mon, 3 Mar 2003 18:31:00 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:50585 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268883AbTCCXa6>; Mon, 3 Mar 2003 18:30:58 -0500
Date: Mon, 03 Mar 2003 15:30:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <560080000.1046734218@flay>
In-Reply-To: <20030303225115.GP1195@holomorphy.com>
References: <20030302202451.GJ1195@holomorphy.com> <50380000.1046637959@[10.10.2.4]> <20030302210606.GS24172@holomorphy.com> <85980000.1046642338@[10.10.2.4]> <20030302221037.GK1195@holomorphy.com> <87420000.1046646801@[10.10.2.4]> <20030302234252.GL1195@holomorphy.com> <88060000.1046650020@[10.10.2.4]> <20030303014320.GM1195@holomorphy.com> <29220000.1046713200@[10.10.2.4]> <20030303225115.GP1195@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, that seems to get rid of the SDET degradation, but I rigged up the
>> same test you were doing (make -j) and see only marginal improvement
>> from the full patch (pernode2) ... not the 6s you were seeing.
>> -pernode2 was your full patch with the fix you sent, -pernode3 was the 
>> smaller patch you sent last. Can you try to reproduce the improvment
>> were seeing, and grab a before and after profile? I don't seem to be 
>> able to replicate it.
> 
> Then there must have been something important in the new per_cpu users.

-pernode2 had all your changes ... but I still don't see anything like
the order of magnitude of benefit you were seeing.

M.

