Return-Path: <linux-kernel-owner+w=401wt.eu-S932813AbWL0NTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbWL0NTO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 08:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbWL0NTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 08:19:13 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:43023 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932810AbWL0NTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 08:19:13 -0500
Message-Id: <200612271318.kBRDIHjU008457@laptop13.inf.utfsm.cl>
To: Theodore Tso <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
       Arnd Bergmann <arnd@arndb.de>, Karel Zak <kzak@redhat.com>,
       linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>
Subject: Re: util-linux: orphan 
In-Reply-To: Message from Theodore Tso <tytso@mit.edu> 
   of "Tue, 26 Dec 2006 23:35:01 CDT." <20061227043501.GA7821@thunk.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Wed, 27 Dec 2006 10:18:17 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 27 Dec 2006 10:18:18 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fedora rawhide (i686):

$ rpm -qf /bin/mount
util-linux-2.13-0.48.fc7

$ ldd /bin/mount
        linux-gate.so.1 =>  (0x00f9b000)
        libblkid.so.1 => /lib/libblkid.so.1 (0x45dbc000)
        libuuid.so.1 => /lib/libuuid.so.1 (0x45db6000)
        libselinux.so.1 => /lib/libselinux.so.1 (0x43c5c000)
        libc.so.6 => /lib/libc.so.6 (0x430d9000)
        libdevmapper.so.1.02 => /lib/libdevmapper.so.1.02 (0x4329c000)
        libdl.so.2 => /lib/libdl.so.2 (0x43255000)
        libsepol.so.1 => /lib/libsepol.so.1 (0x43c8b000)
        /lib/ld-linux.so.2 (0x5e3f7000)

Aurora Corona (SPARC64):

$ rpm -qf /bin/mount
util-linux-2.13-0.44.sparc.al3

$ ldd /bin/mount
        libblkid.so.1 => /lib/libblkid.so.1 (0xf7fbc000)
        libuuid.so.1 => /lib/libuuid.so.1 (0xf7fa8000)
        libselinux.so.1 => /lib/libselinux.so.1 (0xf7f80000)
        libc.so.6 => /lib/libc.so.6 (0xf7e10000)
        libdevmapper.so.1.02 => /lib/libdevmapper.so.1.02 (0xf7dfc000)
        libdl.so.2 => /lib/libdl.so.2 (0xf7de4000)
        libsepol.so.1 => /lib/libsepol.so.1 (0xf7d88000)
        /lib/ld-linux.so.2 (0x70000000)

CentOS 4.4 (x86_64):

$ rpm -qf /bin/mount
util-linux-2.12a-16.EL4.20

$ ldd /bin/mount
        libc.so.6 => /lib64/tls/libc.so.6 (0x00000031d6c00000)
        /lib64/ld-linux-x86-64.so.2 (0x000000552aaaa000)

All look fine to me.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
