Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312581AbSDENXz>; Fri, 5 Apr 2002 08:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312585AbSDENXq>; Fri, 5 Apr 2002 08:23:46 -0500
Received: from z06.nvidia.com ([209.213.198.25]:36774 "EHLO thelma.nvidia.com")
	by vger.kernel.org with ESMTP id <S312581AbSDENX3>;
	Fri, 5 Apr 2002 08:23:29 -0500
From: Gareth Hughes <gareth@nvidia.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Message-ID: <3CADA518.1060705@nvidia.com>
Date: Fri, 05 Apr 2002 05:22:32 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Rik van Riel wrote:
 >
 > The fact that users have problems with different binary-only
 > modules not being available for the same kernel version seems
 > to prove that the "interface" EXPORT_SYMBOL "defines" isn't
 > stable.
 >
 > If it was, we'd have an nvidia driver for 2.4, not a whole
 > serie for each 2.4.x kernel.

Actually, I think you have the driver RPMs confused with the driver 
itself.  We supply prebuilt RPMs for all of the major RPM-based distros 
with every driver release.

All of the source code that interacts with the Linux kernel is available 
in the kernel driver tarball.  This has allowed many people to run the 
driver on the officially-unsupported 2.5 kernels, for instance.

The current driver supports all kernels from 2.2.12 through to 2.4.18 
(at least).

--
Gareth Hughes
Linux OpenGL Engineer
NVIDIA Corporation
gareth@nvidia.com

