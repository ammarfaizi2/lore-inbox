Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSHAUvT>; Thu, 1 Aug 2002 16:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSHAUvS>; Thu, 1 Aug 2002 16:51:18 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:14993 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317024AbSHAUum>; Thu, 1 Aug 2002 16:50:42 -0400
Date: Thu, 1 Aug 2002 14:54:08 -0600
Message-Id: <200208012054.g71Ks8t12065@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Willy TARREAU <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] solved APM bug with -rc5
In-Reply-To: <200208012052.g71KqG311998@vindaloo.ras.ucalgary.ca>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
	<20020801121205.GA168@pcw.home.local>
	<20020801133202.GA200@pcw.home.local>
	<1028213732.14865.50.camel@irongate.swansea.linux.org.uk>
	<20020801135623.GA19879@alpha.home.local>
	<20020801152459.GA19989@alpha.home.local>
	<1028220826.14865.69.camel@irongate.swansea.linux.org.uk>
	<20020801203520.GA244@pcw.home.local>
	<200208012052.g71KqG311998@vindaloo.ras.ucalgary.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch writes:
> Hm. I bet you didn't try this with CONFIG_PREEMPT=y, right? IIRC, the
> wonderful world of preemption means that you can get rescheduled on
> another CPU without warning, unless you take a lock or explicitely
> disable preemption.

Apologies. I forgot that CONFIG_PREEMPT is a 2.5.x feature, and
doesn't exist on 2.4 (thankfully).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
