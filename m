Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUDAUsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUDAUsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:48:36 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:41737 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263156AbUDAUsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:48:30 -0500
Date: Thu, 1 Apr 2004 12:46:28 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, wli@holomorphy.com
Subject: Re: [PATCH] mask ADT: replace cpumask_t implementation [3/22]
Message-Id: <20040401124628.2d017aeb.pj@sgi.com>
In-Reply-To: <1080852024.9787.87.camel@arrakis>
References: <20040329041256.0f27e8c4.pj@sgi.com>
	<1080611340.6742.147.camel@arrakis>
	<20040401072232.798d98c8.pj@sgi.com>
	<1080852024.9787.87.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew suggested:
> Maybe we could #define it better on UP.  Something along the lines of:
> #define cpu_online_map	({ cpumask_t up_cpu_map = { 1UL }; })

Yeah - I started playing with something like that too ...

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
