Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbREHHtS>; Tue, 8 May 2001 03:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbREHHtJ>; Tue, 8 May 2001 03:49:09 -0400
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:10805 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S131317AbREHHtB>; Tue, 8 May 2001 03:49:01 -0400
Date: Tue, 8 May 2001 01:53:39 +0200
Message-Id: <200105072353.f47NrdI00854@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: kernel@stirfried.vegetable.org.uk (Tim Haynes),
        linux-kernel@vger.kernel.org
Subject: Re: ipv6 activity causing system hang in kernel 2.4.4
In-Reply-To: <871yq3mllw.fsf@straw.pigsty.org.uk>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: E233 4EB2 BC46 44A7 C5FC  14C7 54ED 2FE8 FEB9 8835
X-Key-ID: 829B1533
User-Agent: tin/1.5.9-20010328 ("Blue Water") (UNIX) (Linux/2.4.4 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <871yq3mllw.fsf@straw.pigsty.org.uk> you wrote:

> This is only with kernel 2.4.4; 2.4.2, 2.4.3 and NetBSD boxes are not
> affected. It is independent of platform; I've reproduced it at will on a
> lowly p75, an athlon, a p3-800 and on a powerbook/PPC.

I have just reproduced that on 2.4.5pre-1. It was only one ping (ping6)
(from the other side of ipv6 over ipv4 tunnel.


> All kernels are compiled to have ipv6 modular, netfilter modular...
> everything with which I'm playing, modular.

My configuration is without any ipv6/netfilter modules - all build in kernel.

portraits:~# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)

glibc-2.2.2-10 (i686) - RedHat 7.1, 1GB RAM, 2x Pentium III



-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
