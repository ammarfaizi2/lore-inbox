Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267749AbTATCIu>; Sun, 19 Jan 2003 21:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267750AbTATCIu>; Sun, 19 Jan 2003 21:08:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:31927 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267749AbTATCIt>; Sun, 19 Jan 2003 21:08:49 -0500
Date: Sun, 19 Jan 2003 18:17:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
cc: akpm@zip.com.au
Subject: Re: setup_ioapic_ids_from_mpc()
Message-ID: <94060000.1043029068@titus>
In-Reply-To: <20030120011906.GJ780@holomorphy.com>
References: <20030119130118.GC770@holomorphy.com> <20030120011906.GJ780@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Use NUMA-Q specific MP OEM tables to program the physical APIC ID's of
> the IO-APIC's. This fixes boot-time panic()'s on NUMA-Q's in the stock
> version of setup_ioapic_ids_from_mpc().

I think you can just skip this whole routine altogether on NUMA-Q,
it's all pre-programmed for us by firmware. Much smaller patch ;-)

M.

