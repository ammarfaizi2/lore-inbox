Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315722AbSECVho>; Fri, 3 May 2002 17:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315724AbSECVhn>; Fri, 3 May 2002 17:37:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60294 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315722AbSECVhn>; Fri, 3 May 2002 17:37:43 -0400
Date: Fri, 03 May 2002 15:35:52 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: root@chaos.analogic.com, Jeff Dike <jdike@karaya.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was Discontigmem virt_to_page() ) 
Message-ID: <222870000.1020465352@flay>
In-Reply-To: <Pine.LNX.3.95.1020503152328.8539A-100000@chaos.analogic.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No. It's not stupid. Unix defines a kind of operating system that
> has certain characteristics and/or attributes. Process/kernel shared
> address space is one of them. It's a name that has historical
> signifigance.

Yes it is stupid. This is a small implementation detail, and has no
real importance whatsoever. People have done this in the past
(Dynix/PTX did it) will do so in the future. Nor does the kernel 
address space have to be global and shared across all tasks
as stated earlier in this thread. What makes it Unix is the interface
it presents to the world, and how it behaves, not the little details
of how it's implemented inside.

M.

PS. I've been told Solaris x86 can do 4Gb for each of kernel
and user space, though I've no first hand experience with that
OS.
