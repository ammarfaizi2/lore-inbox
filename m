Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311615AbSCNNUL>; Thu, 14 Mar 2002 08:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311616AbSCNNTw>; Thu, 14 Mar 2002 08:19:52 -0500
Received: from xenial.mcc.ac.uk ([130.88.203.16]:30477 "EHLO xenial.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S311615AbSCNNTl>;
	Thu, 14 Mar 2002 08:19:41 -0500
Date: Thu, 14 Mar 2002 13:19:36 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Dan Kegel <dkegel@ixiacom.com>, Ulrich Drepper <drepper@redhat.com>,
        darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@cygnus.com,
        sam@zoy.org, Xavier Leroy <Xavier.Leroy@inria.fr>,
        linux-kernel@vger.kernel.org, babt@us.ibm.com
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem (one li\ne)>
Message-ID: <20020314131935.GB10729@compsoc.man.ac.uk>
In-Reply-To: <1016062486.16743.1091.camel@myware.mynet> <3C8FEC76.F1411739@ixiacom.com> <20020314020834.Z2434@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020314020834.Z2434@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 02:08:34AM -0500, Jakub Jelinek wrote:

> Surely don't use timer for profiling.
> Have the compiler generate profiling calls both at function entry and exit
> and use rdtsc/whatever other register your machine has (or even better
> profiling registers) to note time of that function being entered/left.

http://www710.univ-lyon1.fr/~yperret/fnccheck/

regards
john

-- 
I am a complete moron for forgetting about endianness. May I be
forever marked as such.
