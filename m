Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbSJDTE2>; Fri, 4 Oct 2002 15:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262096AbSJDTE1>; Fri, 4 Oct 2002 15:04:27 -0400
Received: from franka.aracnet.com ([216.99.193.44]:34706 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261921AbSJDTE1>; Fri, 4 Oct 2002 15:04:27 -0400
Date: Fri, 04 Oct 2002 12:07:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] patch-slab-split-03-tail
Message-ID: <1121907497.1033733278@[10.10.2.3]>
In-Reply-To: <3D9DE69C.C6E88C9F@digeo.com>
References: <3D9DE69C.C6E88C9F@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Run that by me again?  So we're saying "if we just freed an
> object from this page then make this page be the *last* page
> which is eligible for new allocations"?  Under the assumption
> that other objects in that same page are about to be freed
> up as well?
> 
> Makes sense.  It would be nice to get this confirmed in 
> targetted testing ;)

Just doing my normal boring kernel compile suggest Manfred's 
last big rollup performs exactly the same as without it. Not
sure if that's any help or not ....

M.

