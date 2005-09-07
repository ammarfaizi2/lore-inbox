Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVIGKao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVIGKao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 06:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVIGKao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 06:30:44 -0400
Received: from istanbul.uab.es ([158.109.168.138]:25387 "EHLO istanbul.uab.es")
	by vger.kernel.org with ESMTP id S932101AbVIGKan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 06:30:43 -0400
Date: Wed, 07 Sep 2005 12:31:07 +0200
From: =?ISO-8859-1?Q?M=E0rius_Mont=F3n?= <Marius.Monton@uab.es>
Subject: 'virtual HW' into kernel (SystemC)
To: linux-kernel@vger.kernel.org
Message-id: <431EC16B.2040604@uab.es>
Organization: Cephis-UAB
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_jPtLQnzXqkrJ1dIuguskxA)"
X-Accept-Language: ca, es
X-Enigmail-Version: 0.92.0.0
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-OriginalArrivalTime: 07 Sep 2005 10:31:24.0007 (UTC)
 FILETIME=[4B9EF770:01C5B397]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_jPtLQnzXqkrJ1dIuguskxA)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

Hello all,

I'm a PhD student and I'm focusing on HW/SW co-design.

First of all, a brief introduction to problem:
Nowadays, we can use C++ libraries, called SystemC, to describe HW
behavior, and synthesize with commercial tools.

A SystemC description can be simulated using its own simulator kernel,
and we can indeed wrap a module with its simulator kernel into a C++
class, so we can use it as a 'normal' C++ code...

Our main problem now appears: if we develop a PCI device using SystemC
we cannot start to develop and test the device driver until we have a
real prototype,
and hence, we cannot test our HW with SW.

Our proposal is to develop a set of tools (kernel module, daemon, ...) in
order to use a SystemC model of HW as a virtual device.

With this set of code, when we have SystemC description finished (and
only SystemC code, nor prototype, nor real HW), we will able to start
developing driver, and testing our "virtual HW" with complete SW suite.

At this point, we plan to develop a pci device driver to act as a bridge
between kernel PCI subsystem and SystemC simulator (in user space).

Do you think this implementation is fine? Maybe it's better to register
a new bus
subsystem and link to a daemon to user space to run SystemC simulations?
We are open to any idea or suggestion about it.

Thanks,

Màrius

http://mariusmonton.name
http://cephis.uab.es


--Boundary_(ID_jPtLQnzXqkrJ1dIuguskxA)
Content-type: text/x-vcard; charset=utf-8; name=marius.monton.vcf
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=marius.monton.vcf

begin:vcard
fn;quoted-printable:M=C3=A0rius Mont=C3=B3n
n;quoted-printable;quoted-printable:Mont=C3=B3n;M=C3=A0rius
org;quoted-printable:UAB;Departament de Microelectr=C3=B2nica i Sistemes Electr=C3=B2nics
adr:Campus de la UAB;;QC-2088 ETSE;Bellaterra;Barcelona;08193;SPAIN
email;internet:marius.monton@uab.es
tel;work:+34935813534
x-mozilla-html:TRUE
url:http://cephis.uab.es
version:2.1
end:vcard


--Boundary_(ID_jPtLQnzXqkrJ1dIuguskxA)--
