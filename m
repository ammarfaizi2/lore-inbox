Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314199AbSDQXbG>; Wed, 17 Apr 2002 19:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314201AbSDQXbF>; Wed, 17 Apr 2002 19:31:05 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:3253 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314200AbSDQXbF>;
	Wed, 17 Apr 2002 19:31:05 -0400
Date: Wed, 17 Apr 2002 17:29:31 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Stevie O <stevie@qrpff.net>, Adam Kropelin <akropel1@rochester.rr.com>
cc: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
        davej@suse.de, Brian Gerst <bgerst@didntduck.org>
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <1870060000.1019089771@flay>
In-Reply-To: <5.1.0.14.2.20020417185436.00aefdb8@whisper.qrpff.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Even though clustered_apic_mode is 0, the compiler still complains
>>> about the second one and the first one doesn't depend on
>>> clustered_apic_mode at all.
>> 
>> Hmmm ... not sure why the compiler complains about the second one,
>> that's very strange ;-)
> 
> That's because we're using C. If we rewrote the kernel in FORTRAN, the
> FORTRAN compiler would happily let us redefine 0 to any other value :)

I think you're missing the point. It shouldn't be compiling that whole if
clause
at all, as far as I can see.

M.

