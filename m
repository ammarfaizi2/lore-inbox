Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314193AbSDQXBu>; Wed, 17 Apr 2002 19:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314194AbSDQXBt>; Wed, 17 Apr 2002 19:01:49 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:25102
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S314193AbSDQXBt>; Wed, 17 Apr 2002 19:01:49 -0400
Message-Id: <5.1.0.14.2.20020417185436.00aefdb8@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Apr 2002 18:56:15 -0400
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Adam Kropelin <akropel1@rochester.rr.com>
From: Stevie O <stevie@qrpff.net>
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Cc: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
        davej@suse.de, Brian Gerst <bgerst@didntduck.org>
In-Reply-To: <2673595977.1019032098@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:28 AM 4/17/2002 -0700, Martin J. Bligh wrote:
>> Even though clustered_apic_mode is 0, the compiler still complains
>> about the second one and the first one doesn't depend on
>> clustered_apic_mode at all.
>
>Hmmm ... not sure why the compiler complains about the second one,
>that's very strange ;-)

That's because we're using C. If we rewrote the kernel in FORTRAN, the FORTRAN compiler would happily let us redefine 0 to any other value :)

(How bout it guys? We could rewrite the kernel in C++, then run a C++-to-FORTRAN conversion script on it!)


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

