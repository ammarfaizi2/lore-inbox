Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273237AbRIJG4i>; Mon, 10 Sep 2001 02:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273236AbRIJG4W>; Mon, 10 Sep 2001 02:56:22 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:30215 "EHLO
	anduin.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S273230AbRIJG4M>; Mon, 10 Sep 2001 02:56:12 -0400
Date: Mon, 10 Sep 2001 08:56:23 +0200
From: Jan Niehusmann <jan@gondor.com>
To: "J. Dow" <jdow@earthlink.net>
Cc: linux-kernel@vger.kernel.org, Carsten Leonhardt <leo@arioch.oche.de>
Subject: Re: Athlon/K7-Opimisation problems
Message-ID: <20010910085623.A9578@gondor.com>
In-Reply-To: <87g09w70o4.fsf@cymoril.oche.de> <01090915115400.00173@c779218-a><063301c1397e$0efa6d00$1125a8c0@wednesday><01090915292502.00173@c779218-a> <87iter6i1k.fsf@cymoril.oche.de> <068b01c139c2$d6ae9990$1125a8c0@wednesday>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068b01c139c2$d6ae9990$1125a8c0@wednesday>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 11:35:52PM -0700, J. Dow wrote:
> From: "Carsten Leonhardt" <leo@arioch.oche.de>
> > Currently I added a burnK7 and a burnMMX to the load, I'll see if the
> > machine is still alive in the morning...
> 
> Far better is run burnK7 and burnMMX alternately in one second on one second
> off cycles alternating the loads with each on second. This gives you the

The one Duron I have access to which doesn't like the athlon optimsed 
kernels did crash some seconds after starting a little test program which
does use the kernel copy code in user space.
Note that neither burnK7 nor burnMMX use the kernel copy code, but 
Robert Redelmeier (author of these two programs) has a burnMMX3 program
which uses kernel-equivalent code.

Jan


