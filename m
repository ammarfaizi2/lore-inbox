Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266972AbSKLVpa>; Tue, 12 Nov 2002 16:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266975AbSKLVp3>; Tue, 12 Nov 2002 16:45:29 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:7306 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266972AbSKLVp2>;
	Tue, 12 Nov 2002 16:45:28 -0500
Date: Tue, 12 Nov 2002 14:46:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <177250000.1037141189@flay>
In-Reply-To: <20021112213906.GW23425@holomorphy.com>
References: <E18BaIc-0006Zs-00@holomorphy> <20021112205241.GS23425@holomorphy.com> <3DD172B8.8040802@us.ibm.com> <20021112213504.GV23425@holomorphy.com> <20021112213906.GW23425@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, every PCI bridge in my box has a bus number of 3 so the lookup
> table will produce wrong answers every time.

Isn't that the local bus number though? The topology functions take
global bus numbers, which should be unique ...

M.

