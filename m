Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261462AbSJYQOz>; Fri, 25 Oct 2002 12:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbSJYQOz>; Fri, 25 Oct 2002 12:14:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:45512 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261462AbSJYQOy>;
	Fri, 25 Oct 2002 12:14:54 -0400
Subject: Re: writepage return value check in vmscan.c
From: Paul Larson <plars@linuxtestproject.org>
To: Andrew Morton <akpm@digeo.com>
Cc: chrisl@vmware.com, Andrea Arcangeli <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, chrisl@gnuchina.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3DB86650.1C48F044@digeo.com>
References: <20021024082505.GB1471@vmware.com>
	<3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com>
	<20021024183327.GS3354@dualathlon.random>
	<20021024191531.GD1398@vmware.com> <3DB85C1B.62D14184@digeo.com>
	<20021024212313.GF1398@vmware.com>  <3DB86650.1C48F044@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Oct 2002 11:11:41 -0500
Message-Id: <1035562304.5646.171.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 16:29, Andrew Morton wrote:
> -ac kernels have an lru per zone and so would not be bitten
> by this failure.  If indeed you are striking this problem,
> which is described at
> http://mail.nl.linux.org/linux-mm/2002-08/msg00049.html
Is it the 2.4 or 2.5 (or both) ac kernels that have the per zone lru?  I
have some stuff I'd like to try with that.

Thanks,
Paul Larson

