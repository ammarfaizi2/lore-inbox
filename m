Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130033AbQKHWFM>; Wed, 8 Nov 2000 17:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129938AbQKHWEw>; Wed, 8 Nov 2000 17:04:52 -0500
Received: from puce.csi.cam.ac.uk ([131.111.8.40]:6811 "EHLO
	puce.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129118AbQKHWET>; Wed, 8 Nov 2000 17:04:19 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: George Anzinger <george@mvista.com>
Subject: Re: Installing kernel 2.4
Date: Wed, 8 Nov 2000 22:01:41 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200011081205.eA8C5ui27838@pincoya.inf.utfsm.cl> <00110819463200.01915@dax.joh.cam.ac.uk> <3A09B856.EC897A92@mvista.com>
In-Reply-To: <3A09B856.EC897A92@mvista.com>
MIME-Version: 1.0
Message-Id: <00110822033500.04252@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2000, George Anzinger wrote:
> "James A. Sutherland" wrote:
> > 
> > On Wed, 08 Nov 2000, George Anzinger wrote:
> > > But, here the customer did run the configure code (he said he did not
> > > change anything).  Isn't this where the machine should be diagnosed and
> > > the right options chosen?  Need a way to say it is a cross build, but
> > > that shouldn't be too hard.
> > 
> > Why default to incompatibility?! If the user explicitly says "I really do want
> > a kernel which only works on this specific machine as it is now, and I want it
> > to break otherwise", fine. Don't make it a default!
> 
> I could go along with this.  The user, however, had the default break,
> and, to my knowledge, there are no tools to diagnose the current (or any
> other) machine anywhere in the kernel.  Maybe it is time to do such a
> tool with exports that the configure programs could use as defaults.  My
> thought is that the tool could run independently on the target system
> (be it local or otherwise) with the results fed back to configure.

I think a default whereby the kernel built will run on any Linux-capable
machine of that architecture would be sensible - so if I grab the 2.4.0t10
tarball and build it now, with no changes, I'll be able to boot the kernel on
any x86 machine.

> (Oops, corollary to the rule that "The squeaking wheel gets the grease."
> is "S/he who complains most about the squeaking gets to do the
> greasing."  I better keep quiet :)

I'm still not convinced the wheel IS squeaking - anyone got those benchmarks??


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
