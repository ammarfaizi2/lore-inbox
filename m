Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUAJQTc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAJQTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:19:32 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:13702
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265244AbUAJQT2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:19:28 -0500
Subject: Re: 2.6.0 NFS-server low to 0 performance
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3eku74whi.fsf@averell.firstfloor.org>
References: <1cpDr-5az-11@gated-at.bofh.it> <1csrv-Er-9@gated-at.bofh.it>
	 <m3eku74whi.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073751567.1146.47.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 11:19:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 10/01/2004 klokka 11:08, skreiv Andi Kleen:
> Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> > The correct solution to this problem is (b). I.e. we convert mount to
> > use TCP as the default if it is available. That is consistent with what
> > all other modern implementations do.
> 
> Please do that. Fragmented UDP with 16bit ipid is just russian roulette at 
> today's network speeds.

I fully agree.

Chuck Lever recently sent an update for the NFS 'mount' utility to
Andries. Among other things, that update changes this default. We're
still waiting for his comments.

Cheers,
  Trond
