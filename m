Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266314AbUALO1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 09:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266326AbUALO1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 09:27:37 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:7555
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S266314AbUALO1g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 09:27:36 -0500
Subject: Re: 2.6.0 NFS-server low to 0 performance
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <btt971$3p8$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange>
	 <1073745028.1146.13.camel@nidelv.trondhjem.org>
	 <btt971$3p8$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073917652.1639.21.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 09:27:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 12/01/2004 klokka 00:06, skreiv Bill Davidsen:
> Why do so many Linux people have the idea that because a standard says 
> they CAN do something, it's fine to do it in a way which doesn't conform 
> to common practice. And Linux 2.4 practice should count even if you 
> pretend that Solaris, AIX, Windows and BSD don't count...

Wake up and smell the new millennium. Networking has all grown up while
you were asleep. We have these new cool things called "switches", NICs
with bigger buffers,...


The 8k limit that you find in RFC1094 was an ad-hoc "limit" based purely
on testing using pre-1989 hardware. AFAIK most if not all of the
commercial vendors (Solaris, AIX, Windows/Hummingbird, EMC and Netapp)
are all currently setting the defaults to 32k block sizes for both TCP
and UDP.
Most of them want to bump that to a couple of Mbyte in the very near
future.

Linux 2.4 didn't have support for anything beyond 8k. BSD sets 32k for
TCP, and 8k for UDP for some reason.

Trond
