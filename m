Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSHHSMV>; Thu, 8 Aug 2002 14:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSHHSMV>; Thu, 8 Aug 2002 14:12:21 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:30379 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317326AbSHHSMU>; Thu, 8 Aug 2002 14:12:20 -0400
Date: Thu, 08 Aug 2002 11:14:06 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: further IO-APIC oddities
Message-ID: <73720000.1028830446@flay>
In-Reply-To: <20020808180743.GD15685@holomorphy.com>
References: <20020808162856.GD6256@holomorphy.com> <70720000.1028829388@flay> <20020808180743.GD15685@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's different from 2.5.29, I can follow up with that. 2.5.29 saw all 0's,
> so whatever it was that was scribbling over the MPC table and making the
> ID's all 0, it's scribbling on something else now (probably mem_map).

I thought that was only if you reduced NR_CPUS? And you shouldn't
need to read the IOAPIC tables to do that - the basic array was getting
overwritten. Or am I confusing at least two different bugs?

M.

