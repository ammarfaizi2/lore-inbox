Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUECRyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUECRyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 13:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUECRyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 13:54:55 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:41679 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263806AbUECRyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 13:54:52 -0400
Date: Mon, 3 May 2004 10:57:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Zoltan.Menyhart@bull.net
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: NUMA API - wish list
Message-Id: <20040503105735.39bee800.pj@sgi.com>
In-Reply-To: <40963FAB.DF49BC3E@nospam.org>
References: <409201BE.9000909@redhat.com>
	<40963FAB.DF49BC3E@nospam.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The operating systems should provide for abstractions of the actual ...

True ... so long as you don't confuse "operating system" with "kernel".

Most of what you describe can and should be in user space, as what I
call "system software", constructed of libraries, daemons, utilities
and specific language support.

Having the kernel support the abstraction of "file", to hide details of
sectors, channels and devices has been a great success.  But the kernel
doesn't need to support every such abstraction, such as in this case
"abstract computers" with certain amounts of compute, memory and i/o
resources.

Rather the kernel only needs to provide the essential primitives, such
as cpu and memory placement, jobs (as related set of tasks), and access
to primitive topology and hardware attributes.

(Your spam encoded from address "Zoltan.Menyhart_AT_bull.net@nospam.org"
is a minor annoyance ...).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
