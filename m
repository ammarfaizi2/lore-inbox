Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSKIWrg>; Sat, 9 Nov 2002 17:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSKIWrf>; Sat, 9 Nov 2002 17:47:35 -0500
Received: from franka.aracnet.com ([216.99.193.44]:5340 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262803AbSKIWrf>; Sat, 9 Nov 2002 17:47:35 -0500
Date: Sat, 09 Nov 2002 14:51:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] numa slab, rediffed against 2.5.46
Message-ID: <4245515969.1036853468@[10.10.2.3]>
In-Reply-To: <3DCD4B30.2090204@colorfullife.com>
References: <3DCD4B30.2090204@colorfullife.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - implement ptr_to_nodeid() for all archs.The current implementation is a dummy, to test the code on non-NUMA systems.

Physical or virtual pointer? I think pa_to_nid exists for some
if not all arches already, so pa_to_nid(__pa(vaddr)) or pa_to_nid(paddr)
should work.

M.

