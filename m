Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSKVPit>; Fri, 22 Nov 2002 10:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbSKVPit>; Fri, 22 Nov 2002 10:38:49 -0500
Received: from franka.aracnet.com ([216.99.193.44]:64222 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264956AbSKVPit>; Fri, 22 Nov 2002 10:38:49 -0500
Date: Fri, 22 Nov 2002 07:42:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
cc: Sam Ravnborg <sam@ravnborg.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] subarch cleanup 
Message-ID: <1047956111.1037950936@[10.10.2.3]>
In-Reply-To: <200211221500.gAMF0lh02117@localhost.localdomain>
References: <200211221500.gAMF0lh02117@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Header files go under include .... 
> 
> That's not necessarily true.  Externally useful header files go 
> in include.  Header files only used internally to the subsystem 
> go in local directories.

That's not true either. There are lots of header files under the
include tree that aren't externally useful. And every other header
file is under the include path ... putting them all mixed in with
C files is just making a mess.

> The reason I put them under arch/i386 is because I didn't want the 
> guts of the  subarch splitup spilling into the kernel core.

Que? How is include/asm-i386 any more "kernel core" than arch/i386?

M.

