Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbUC2FPI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 00:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUC2FPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 00:15:07 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:51492 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262675AbUC2FPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 00:15:05 -0500
Date: Sun, 28 Mar 2004 21:14:15 -0800
From: Paul Jackson <pj@sgi.com>
To: Keith Owens <kaos@sgi.com>
Cc: wli@holomorphy.com, colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7]
Message-Id: <20040328211415.6754b296.pj@sgi.com>
In-Reply-To: <4865.1080536926@kao2.melbourne.sgi.com>
References: <20040325231412.2a3d1c15.pj@sgi.com>
	<4865.1080536926@kao2.melbourne.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> how you represent an incomplete bit map

See the follow files for the best available documentation of how bitmaps
are layed out.  The representation is little-endian friendly, so the
big-endian arch's had to struggle with it the most, and ended up
documenting it the best.

	include/asm-ppc64/bitops.h
	include/asm-s390/bitops.h

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
