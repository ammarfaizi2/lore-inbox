Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275694AbTHOICR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 04:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275699AbTHOICR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 04:02:17 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:47181 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S275694AbTHOICL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 04:02:11 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Dave Jones <davej@redhat.com>
Subject: Re: Via KT400 agpgart issues
Date: Fri, 15 Aug 2003 08:59:03 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200308141025.12747.m.watts@eris.qinetiq.com> <20030814184838.GB10901@redhat.com>
In-Reply-To: <20030814184838.GB10901@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308150859.03617.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Thu, Aug 14, 2003 at 10:25:12AM +0100, Mark Watts wrote:
>  > Ok, I _am_ using the nVidia modules (on 2.4.21) but the fact that the
>  > agpgart driver can't sense my agp apature size is concerning... (its set
>  > to 256MB in the bios)
>  >
>  > 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496 
>  > Wed Jul 16 19:03:09 PDT 2003
>  > Linux agpgart interface v0.99 (c) Jeff Hartmann
>  > agpgart: Maximum main memory to use for agp memory: 439M
>  > agpgart: Detected Via Apollo Pro KT400 chipset
>  > agpgart: unable to determine aperture size.
>  > 0: NVRM: AGPGART: unable to retrieve symbol table
>  >
>  > I'm running a GeForce FX 5600 128Mb with AGP 3.0 support enabled.
>  > It seems to run ok, but its slower than the Ti 4200-4x I took out by a
>  > larger margin than it really should be (according to the benchmarks I've
>  > seen scattered through the internet.)
>  > I'm also running with the Local APIC turned on (it doesnt seem to break
>  > anything).
>  >
>  > Is anything actually broken or is this nothing to worry about?
>
> Caused due to lack of AGP 3.x support in 2.4
> See 2.6.0-test

I thought the KT400 chipset (at least) had been backported to 2.4.21 ?

I'm not experiancing any technical problems. The nvidia /proc interfaces are 
reporting that I'm running at agp 8x, and I have full hardware acceleration 
enough to play games like Unreal Tournament 2003 quite fast (~50fps), its 
just that agpgart cant find my aperature size...

I just tried my vendors (mandrake) 2.4.22 kernel and I get exactly the same 
output.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/PJLHBn4EFUVUIO0RAmpxAJ498GmynIcnEJuFHsqpEOwwo+41JQCg1Dzt
R1AKFPcR3kZzAz/s1/NyKbk=
=4oQ+
-----END PGP SIGNATURE-----

