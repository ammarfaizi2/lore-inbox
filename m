Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVC3GRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVC3GRT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVC3GRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:17:19 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:32232 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261736AbVC3GRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:17:14 -0500
Date: Tue, 29 Mar 2005 22:16:11 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Cc: jengelh@linux01.gwdg.de, penberg@gmail.com, rlrevell@joe-job.com,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: no need to check for NULL before calling kfree() -fs/ext2/
Message-Id: <20050329221611.6ce294d7.pj@engr.sgi.com>
In-Reply-To: <courier.424A43A5.00002305@courier.cs.helsinki.fi>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	<1111825958.6293.28.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	<Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
	<1111881955.957.11.camel@mindpipe>
	<Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
	<20050327065655.6474d5d6.pj@engr.sgi.com>
	<Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
	<20050327174026.GA708@redhat.com>
	<1112064777.19014.17.camel@mindpipe>
	<84144f02050328223017b17746@mail.gmail.com>
	<Pine.LNX.4.61.0503290903530.13383@yvahk01.tjqt.qr>
	<courier.42490293.000032B0@courier.cs.helsinki.fi>
	<20050329184411.1faa71eb.pj@engr.sgi.com>
	<courier.424A43A5.00002305@courier.cs.helsinki.fi>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka writes:
> It is not a performance issue, it's an API issue.
> ...
> I am all for profiling but it should not stop us from merging the patches 

Ok - sounds right.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
