Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWHGJbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWHGJbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 05:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWHGJbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 05:31:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60857 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751180AbWHGJbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 05:31:23 -0400
Date: Mon, 7 Aug 2006 02:30:25 -0700
From: Paul Jackson <pj@sgi.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: nagar@watson.ibm.com, akpm@osdl.org, vatsa@in.ibm.com, mingo@elte.hu,
       nickpiggin@yahoo.com.au, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       haveblue@us.ibm.com
Subject: Re: [ProbableSpam] Re: [RFC, PATCH 0/5] Going forward with Resource
 Management - A cpu  controller
Message-Id: <20060807023025.2c44f3d1.pj@sgi.com>
In-Reply-To: <44D6EBEF.9010804@sw.ru>
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
	<44D35794.2040003@sw.ru>
	<44D367F3.8060108@watson.ibm.com>
	<44D6EBEF.9010804@sw.ru>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill wrote:
> > A filesystem based interface is useful when you have hierarchies (as resource
> > groups and cpusets do) since it naturally defines a convenient to use
> > hierarchical namespace.
> but it is not much convinient for applications then.

Is this simply a language issue?  File systems hierarchies
are more easily manipulated with shell utilities (ls, cat,
find, grep, ...) and system call API's are easier to access
from C?

If so, then perhaps all that's lacking for convenient C access
to a filesystem based interface is a good library, that presents
an API convenient for use from C code, but underneath makes the
necessary file system calls (open, read, diropen, stat, ...).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
