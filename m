Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269023AbTBXC4x>; Sun, 23 Feb 2003 21:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269094AbTBXC4x>; Sun, 23 Feb 2003 21:56:53 -0500
Received: from franka.aracnet.com ([216.99.193.44]:1760 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269023AbTBXC4w>; Sun, 23 Feb 2003 21:56:52 -0500
Date: Sun, 23 Feb 2003 19:07:01 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pte-highmem vs UKVA (was: object-based rmap and pte-highmem)
Message-ID: <44200000.1046056020@[10.10.2.4]>
In-Reply-To: <22420000.1046038049@[10.10.2.4]>
References: <Pine.LNX.4.44.0302231335090.1534-100000@home.transmeta.com>
 <22420000.1046038049@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This just just for PTEs ... for which at the moment we have two choices:
> 1. Stick them in lowmem (fills up the global space too much).
> 2. Stick them in highmem - too much overhead doing k(un)map_atomic
>    as measured by both myself and Andrew.

Actually Andrew's measurements seem to be a bit different from mine ...
several different things all interacting. I'll try to get some more
measurements from a straight SMP box, and see if they correlate more
closely with what he's seeing.

M.

