Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbUKEBhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbUKEBhY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUKEBgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:36:39 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:39046 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262523AbUKEBer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:34:47 -0500
Subject: Re: power/suspend error
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Dovid Kopel <munky@munkys.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <418AB8DD.6070205@munkys.com>
References: <418AB8DD.6070205@munkys.com>
Content-Type: text/plain
Message-Id: <1099618508.6910.40.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 05 Nov 2004 12:35:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-05 at 10:18, Dovid Kopel wrote:
> This is on an AMD 64 running Gentoo 2004.2. This kernel source is
> gentoo-dev-sources 2.6.9-r2.

Sorry to say this, but Suspend 2 doesn't support AMD64 yet. I'm in the
process of organising access to a machine to get it going. You'll need
to use Pavel's version for now.

Regards,

Nigel

> lappy linux # make && make modules_install
> ~  CHK     include/linux/version.h
> make[1]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
> ~  CHK     include/linux/compile.h
> dnsdomainname: Unknown host
> ~  UPD     include/linux/compile.h
> ~  CC      init/version.o
> ~  LD      init/built-in.o
> ~  CC      kernel/power/suspend_builtin.o
> kernel/power/suspend_builtin.c:15:25: asm/highmem.h: No such file or
> directory
> kernel/power/suspend_builtin.c: In function `get_highstart_pfn':
> kernel/power/suspend_builtin.c:434: error: `highstart_pfn' undeclared
> (first use in this function)
> kernel/power/suspend_builtin.c:434: error: (Each undeclared identifier
> is reported only once
> kernel/power/suspend_builtin.c:434: error: for each function it
> appears in.)
> make[2]: *** [kernel/power/suspend_builtin.o] Error 1
> make[1]: *** [kernel/power] Error 2
> make: *** [kernel] Error 2
> 
> - -=mUnky=-
> - -Dovid Kopel
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.6 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFBirjcCecRKprSbsERAugEAJ48bZfhw1Sal6+3/FfTAmlJ4oIYrQCggXsL
> s95zkMxQKY9g4vmOidDMZ40=
> =w1to
> -----END PGP SIGNATURE-----
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

