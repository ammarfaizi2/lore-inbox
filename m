Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWHGP6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWHGP6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWHGP6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:58:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:9915 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750806AbWHGP6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:58:18 -0400
Subject: Re: [ProbableSpam] Re: [RFC, PATCH 0/5] Going forward with
	Resource Management - A cpu  controller
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: Kirill Korotaev <dev@sw.ru>, nagar@watson.ibm.com, akpm@osdl.org,
       vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, haveblue@us.ibm.com
In-Reply-To: <20060807023025.2c44f3d1.pj@sgi.com>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org> <44D35794.2040003@sw.ru>
	 <44D367F3.8060108@watson.ibm.com> <44D6EBEF.9010804@sw.ru>
	 <20060807023025.2c44f3d1.pj@sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 07 Aug 2006 08:58:14 -0700
Message-Id: <1154966294.1174.38.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 02:30 -0700, Paul Jackson wrote:
> Kirill wrote:
> > > A filesystem based interface is useful when you have hierarchies (as resource
> > > groups and cpusets do) since it naturally defines a convenient to use
> > > hierarchical namespace.
> > but it is not much convinient for applications then.
> 
> Is this simply a language issue?  File systems hierarchies
> are more easily manipulated with shell utilities (ls, cat,
> find, grep, ...) and system call API's are easier to access
> from C?
> 
> If so, then perhaps all that's lacking for convenient C access
> to a filesystem based interface is a good library, that presents
> an API convenient for use from C code, but underneath makes the
> necessary file system calls (open, read, diropen, stat, ...).
> 

I totally agree. 

When the difference comes to language issue, one advantage of filesystem
is that there is no need for a user space app to do simple management.
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


