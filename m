Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269713AbUJGFqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269713AbUJGFqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269710AbUJGFoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:44:07 -0400
Received: from havoc.gtf.org ([69.28.190.101]:56750 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267291AbUJGFn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:43:59 -0400
Date: Thu, 7 Oct 2004 01:43:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why no linux-2.6.8.2? (was Re: new dev model)
Message-ID: <20041007054357.GA23022@havoc.gtf.org>
References: <200410070134_MC3-1-8BA9-A215@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410070134_MC3-1-8BA9-A215@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 01:31:39AM -0400, Chuck Ebbert wrote:
> Why has linux 2.6.8 been abandoned at version 2.6.8.1?
> 
> There exist fixes that could go into 2.6.8.2:
> 
>         process start time doesn't match system time
>         FDDI frame doesn't allow 802.3 hwtype
>         NFS server using XFS filesystem on SMP machine oopses
> 
> I'm sure there are more...
> 
> So why is 2.6.8.1 a "dead branch?"

Since it's in BitKeeper, it's not dead, it's just sleeping...

$ bk clone -ql -rv2.6.8.1 linux-2.6 linux-2.6.8-branch
$ cpcset <cset> linux-2.6 linux-2.6.8-branch
$ # repeat for each <cset> to apply
$ cd linux-2.6.8-branch
$ bk vi Makefile	# bump version
$ bk tag v2.6.8.2
$ # release 2.6.8.2 ...

