Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbUKDXZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbUKDXZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUKDXYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:24:48 -0500
Received: from s9009.hostcentric.net ([66.40.7.4]:18889 "EHLO
	s9009.hostcentric.net") by vger.kernel.org with ESMTP
	id S262349AbUKDXVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:21:49 -0500
Message-ID: <418AB8DD.6070205@munkys.com>
Date: Thu, 04 Nov 2004 23:18:53 +0000
From: Dovid Kopel <munky@munkys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041027)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: power/suspend error
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040202080707010607020801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040202080707010607020801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is on an AMD 64 running Gentoo 2004.2. This kernel source is
gentoo-dev-sources 2.6.9-r2.

lappy linux # make && make modules_install
~  CHK     include/linux/version.h
make[1]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
~  CHK     include/linux/compile.h
dnsdomainname: Unknown host
~  UPD     include/linux/compile.h
~  CC      init/version.o
~  LD      init/built-in.o
~  CC      kernel/power/suspend_builtin.o
kernel/power/suspend_builtin.c:15:25: asm/highmem.h: No such file or
directory
kernel/power/suspend_builtin.c: In function `get_highstart_pfn':
kernel/power/suspend_builtin.c:434: error: `highstart_pfn' undeclared
(first use in this function)
kernel/power/suspend_builtin.c:434: error: (Each undeclared identifier
is reported only once
kernel/power/suspend_builtin.c:434: error: for each function it
appears in.)
make[2]: *** [kernel/power/suspend_builtin.o] Error 1
make[1]: *** [kernel/power] Error 2
make: *** [kernel] Error 2

- -=mUnky=-
- -Dovid Kopel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBirjcCecRKprSbsERAugEAJ48bZfhw1Sal6+3/FfTAmlJ4oIYrQCggXsL
s95zkMxQKY9g4vmOidDMZ40=
=w1to
-----END PGP SIGNATURE-----


--------------040202080707010607020801
Content-Type: text/x-vcard; charset=utf-8;
 name="munky.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="munky.vcf"

begin:vcard
fn:Dovid Kopel
n:Kopel;Dovid
email;internet:munky@munkys.com
tel;cell:(516)-655-0489
x-mozilla-html:FALSE
url:http://www.munkys.com
version:2.1
end:vcard


--------------040202080707010607020801--
