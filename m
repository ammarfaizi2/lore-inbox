Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286348AbRLJS1T>; Mon, 10 Dec 2001 13:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286357AbRLJS1J>; Mon, 10 Dec 2001 13:27:09 -0500
Received: from borderworlds.dk ([193.162.142.101]:23812 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S286348AbRLJS06>; Mon, 10 Dec 2001 13:26:58 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NULL pointer dereference in moxa driver
In-Reply-To: <m3zo4rm05v.fsf@borg.borderworlds.dk>
From: Christian Laursen <xi@borderworlds.dk>
Date: 10 Dec 2001 19:26:52 +0100
In-Reply-To: <m3zo4rm05v.fsf@borg.borderworlds.dk>
Message-ID: <m3vgfflymr.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Laursen <xi@borderworlds.dk> writes:

> I have a problem when trying to use two of the serial cards known as
> MOXA C104H/PCI.
> 
> When only using one, everything works like a charm, but when
> an attempt is made to access a serial port on the second card,
> I get a NULL pointer dereference.
> 

I forgot information about my versions of things in the other post,
here we go:

[xi@borg /usr/src/linux/scripts]$ ./ver_linux                                                                    [19:22]
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux borg 2.4.16 #1 SMP Thu Dec 6 22:23:25 CET 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.29
util-linux             2.11i
mount                  2.11i
modutils               2.4.8
e2fsprogs              1.24a
reiserfsprogs          3.x.0k-pre9
pcmcia-cs              3.1.28
PPP                    2.4.1
isdn4k-utils           3.1pre2
Linux C Library        x    1 root     root      1384168 Sep 20 05:52 /lib/libc.so.6
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         nfsd lockd sunrpc 3c59x

-- 
Med venlig hilsen
    Christian Laursen
