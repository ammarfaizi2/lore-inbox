Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbUKBWv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbUKBWv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbUKBWnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:43:52 -0500
Received: from dialin-212-144-169-200.arcor-ip.net ([212.144.169.200]:32425
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S262359AbUKBWhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:37:13 -0500
In-Reply-To: <1099414727.4618.11.camel@hostmaster.org>
References: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu> <1099414727.4618.11.camel@hostmaster.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-16-868739776"
Message-Id: <B817E9A8-2D1F-11D9-BF00-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: Linux Mailing List Kernel <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: 2.6.8 and 2.6.9 Dual Opteron glitches
Date: Tue, 2 Nov 2004 23:37:03 +0100
To: Thomas Zehetbauer <thomasz@hostmaster.org>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-16-868739776
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 02.11.2004, at 17:58, Thomas Zehetbauer wrote:

> I am using a not-so-new Tyan Thunder K8W S2885 based Dual Opteron
> System.

Mine is a Tyan Tiger K8W. :)

>> 2) 64 bit kernel vgettimeofday panic: The kernel panics in

> Cannot confirm this, both 2.6.8.1 and 2.6.9 boot OK.

Could be the compiler, I'm using a gcc HEAD snapshot from yesterday.

However since I do not have any problems with the panics replaced by
printk I have troubles to understand the meaning of them.

>> 3) Interrupt distribution 32 bit vs. 64 bit. Below is a copy of the

> Cannot confirm this, interrupts seem to be almost equally distributed
> with 64-bit kernel and irqbalance running. Did you note that x86_64 
> does
> not provide in-kernel IRQ balancing.

Fair enough. Thanks for the pointer.

>> 4) ACPI powermanagement (32bit and 64bit): No matter which ACPI 
>> options

> AFAIK power management is almost unsupported on SMP systems.

Strange. The ACPI tables seem to be filled with valueable information
which I can enable pretty finegrained in the BIOS and I even seem to get
somewhat useful options with the first CPU.

Also /proc/cpuinfo mentions powermanagement:
...
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

Whatever ts and ttp may mean.

I'd really love to have this machine running and use its power on demand
instead of having to think about a more sophisticated airflow to keep
the temperature (of idle CPUs) and thus the noiselevel down.

Servus,
       Daniel

--Apple-Mail-16-868739776
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQYgMDzBkNMiD99JrAQIxxwf/QG3S7rXjwYecDEc5Mok+94cl9x9rbCH1
aLfrhlrtnbNX75bhMSgMbKoGTstqGxSkqZfVygC1Bnn+u6paa6r6vIl0Hag9SOl9
0p3g0L8U+kaFofSSedejbCQS1q+8Fr/G7NBq9YfvfQODdysaSEuw6AuyvxRitcDB
SDlqpe/ibX1JOtsHBCqq4C8DYSLBkux9Q5OwttUQ3/hvYqiQlQDgwdzwDOl8w4lo
aTR2B1OIBWKQciNv6gYFZHE1biN20gyNo9MTl1TXAx6bboOG/XvuYk1Wtgj977Ws
04PRohCQRYhTe/nDxbjOGjyDGqr6lUaOmn4P2akXmEKwXx5YaWjqYw==
=jr2s
-----END PGP SIGNATURE-----

--Apple-Mail-16-868739776--

