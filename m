Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267598AbSKSXOf>; Tue, 19 Nov 2002 18:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267600AbSKSXOe>; Tue, 19 Nov 2002 18:14:34 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:37620 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267598AbSKSXOX>; Tue, 19 Nov 2002 18:14:23 -0500
Date: Tue, 19 Nov 2002 15:15:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Dave Richards <drichard@largo.com>
cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: Off List Message - Kernel Problem - Respond To Me
Message-ID: <93810000.1037747752@flay>
In-Reply-To: <20021119220751.GX11776@holomorphy.com>
References: <1037742240.31569.9.camel@oa3> <20021119220751.GX11776@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Nov 19 14:09:41 desktop_a kernel: ldt allocation failed
>> We get this error over and over again and no additional users can log
>> into the server.
>> I'm not on the linux-kernel list, but if anyone has insight into this
>> issue, please drop me a line.  If you know a way to fix this in the 2.4
>> kernel too, or can verify that we have to wait for 2.5/2.6 we need to
>> know that too.
> 
> IIRC this has been hit in threaded benchmarks before; ISTR a fix for LDT
> OOM going around, probably manfred's stuff which is in 2.5 and 2.4-ac.

You can do a dirty hack workaround by increasing VMALLOC_RESERVE as well,
I've done that in the past ...

M.

