Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129476AbQKHU3y>; Wed, 8 Nov 2000 15:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbQKHU3p>; Wed, 8 Nov 2000 15:29:45 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:21513 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129476AbQKHU3d>; Wed, 8 Nov 2000 15:29:33 -0500
Message-ID: <3A09B856.EC897A92@mvista.com>
Date: Wed, 08 Nov 2000 12:32:22 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "James A. Sutherland" <jas88@cam.ac.uk>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <200011081205.eA8C5ui27838@pincoya.inf.utfsm.cl> <00110816543500.01639@dax.joh.cam.ac.uk> <3A098F11.1B89EB7B@mvista.com> <00110819463200.01915@dax.joh.cam.ac.uk>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James A. Sutherland" wrote:
> 
> On Wed, 08 Nov 2000, George Anzinger wrote:
> > But, here the customer did run the configure code (he said he did not
> > change anything).  Isn't this where the machine should be diagnosed and
> > the right options chosen?  Need a way to say it is a cross build, but
> > that shouldn't be too hard.
> 
> Why default to incompatibility?! If the user explicitly says "I really do want
> a kernel which only works on this specific machine as it is now, and I want it
> to break otherwise", fine. Don't make it a default!

I could go along with this.  The user, however, had the default break,
and, to my knowledge, there are no tools to diagnose the current (or any
other) machine anywhere in the kernel.  Maybe it is time to do such a
tool with exports that the configure programs could use as defaults.  My
thought is that the tool could run independently on the target system
(be it local or otherwise) with the results fed back to configure.

(Oops, corollary to the rule that "The squeaking wheel gets the grease."
is "S/he who complains most about the squeaking gets to do the
greasing."  I better keep quiet :)

> 
> BTW: Has anyone benchmarked the different optimizations - i.e. how much
> difference does optimizing for a Pentium make when running on a PII? More to
> the point, how about optimizing non-exclusively for a Pentium, so the code
> still runs on earlier CPUs?
> 
> James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
