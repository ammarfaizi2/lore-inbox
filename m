Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317735AbSGVQog>; Mon, 22 Jul 2002 12:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSGVQog>; Mon, 22 Jul 2002 12:44:36 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:751 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317735AbSGVQof>; Mon, 22 Jul 2002 12:44:35 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E17WgIv-0002Yc-00@starship>
References: <3D361091.13618.16DC46FB@localhost>
	<E17Wf0s-0001tS-00@starship>
	<1027357077.31782.50.camel@irongate.swansea.linux.org.uk> 
	<E17WgIv-0002Yc-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 19:00:27 +0100
Message-Id: <1027360827.32299.64.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 17:45, Daniel Phillips wrote:
> > So we end up with twice as much code to debug and lots of
> > incompatibilities when people want to switch around.
> 
> If that were a problem, Linux would only have one filesystem.

The device mapper functionality is generic. We only have one VFS, we
only need one mapping layer. What cool stuff people build on top of the
mapping layer is another matter. If the mapping layer supports all of
the requirements its done right, if not its borked and wants fixing
first.


