Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130790AbQKIS2L>; Thu, 9 Nov 2000 13:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130811AbQKIS2B>; Thu, 9 Nov 2000 13:28:01 -0500
Received: from puce.csi.cam.ac.uk ([131.111.8.40]:55229 "EHLO
	puce.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130798AbQKIS1y>; Thu, 9 Nov 2000 13:27:54 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Installing kernel 2.4
Date: Thu, 9 Nov 2000 18:24:36 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: George Anzinger <george@mvista.com>,
        Horst von Brand <vonbrand@inf.utfsm.cl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <00110822033500.04252@dax.joh.cam.ac.uk> <3A09B856.EC897A92@mvista.com> <12370.973776350@redhat.com>
In-Reply-To: <12370.973776350@redhat.com>
MIME-Version: 1.0
Message-Id: <00110918264401.06239@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2000, David Woodhouse wrote:
> jas88@cam.ac.uk said:
> >  I think a default whereby the kernel built will run on any
> > Linux-capable machine of that architecture would be sensible - so if I
> > grab the 2.4.0t10 tarball and build it now, with no changes, I'll be
> > able to boot the kernel on any x86 machine.
> 
> I have four machines on my desk at the moment. The workstation is a dual 
> P-III. I suppose I agree that it might be nice if the kernel for that also 
> worked on the embedded 386 board. But it'd also be nice if it worked on the 
> Alpha and the SH boards which are also on my desk. How about putting the 
> whole lot into a single kernel image? It's the logical extension of what's 
> being suggested.

No. In the x86 case, it is a question of "do we deliberately restrict this
kernel to running only on a Pentium II in order to make it x% faster". My
suggestion does not duplicate any code, or (with a few exceptions) include any
redundant code for any platform (maths emulation, e.g., would be an exception).
Yours duplicates code, rather than just not optimising it as aggressively.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
