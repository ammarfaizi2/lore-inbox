Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSIIRcZ>; Mon, 9 Sep 2002 13:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317603AbSIIRcZ>; Mon, 9 Sep 2002 13:32:25 -0400
Received: from franka.aracnet.com ([216.99.193.44]:49132 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S317602AbSIIRcY>; Mon, 9 Sep 2002 13:32:24 -0400
Date: Mon, 09 Sep 2002 10:34:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "David S. Miller" <davem@redhat.com>
cc: imran.badr@cavium.com, phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
Message-ID: <316538358.1031567696@[10.10.2.3]>
In-Reply-To: <20020909.102341.29032821.davem@redhat.com>
References: <20020909.102341.29032821.davem@redhat.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you meant virt_to_phys(), this does not work on arbitrary
> kernel virtual addresses either only direct mapped ones
> (ie. kmalloc() or get_free_page() data).

Though maybe it should ... ;-) This doesn't seem like an
impossible modification, and would be most useful. If people
are concerned about speed, we could create __virt_to_phys
if you knew it was direct mapped ...

M.

