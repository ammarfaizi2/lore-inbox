Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264193AbRGCL7Q>; Tue, 3 Jul 2001 07:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264209AbRGCL64>; Tue, 3 Jul 2001 07:58:56 -0400
Received: from wh58-709.st.Uni-Magdeburg.DE ([141.44.198.79]:10244 "HELO
	wh58-709.st.uni-magdeburg.de") by vger.kernel.org with SMTP
	id <S264193AbRGCL6o>; Tue, 3 Jul 2001 07:58:44 -0400
Date: Tue, 3 Jul 2001 13:58:58 +0200 (CEST)
From: Erik Meusel <erik@wh58-709.st.uni-magdeburg.de>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: include/asm-i386/checksum.h 
In-Reply-To: <2487.994146067@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0107031356200.16796-200000@wh58-709.st.uni-magdeburg.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="747458502-1378787805-994161538=:16796"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--747458502-1378787805-994161538=:16796
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 3 Jul 2001, Keith Owens wrote:

> >P.S.: would it be possible to patch the menuconfig in that way, that it
> >does look in the whole include-path for the <ncurses.h> and relating
> >files? they aren't in /usr/include/ in my system and I'm tired of patching
> >linux/scripts/lxdialog/Makefile all the time. :)
> Where is it on your system?  What patch do you apply?
It is in /usr/local/include/ since I installed it myself, months ago.
The patch is attached. Just made silly to use /usr/local/ instead of /usr/.

mfg, Erik

--747458502-1378787805-994161538=:16796
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="Makefile.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107031358580.16796@wh58-709.st.uni-magdeburg.de>
Content-Description: 
Content-Disposition: attachment; filename="Makefile.diff"

LS0tIC90bXAvbGludXgvc2NyaXB0cy9seGRpYWxvZy9NYWtlZmlsZQlNb24g
SnVuIDE5IDIyOjQ1OjUyIDIwMDANCisrKyAvc2NyYXRjaC9iYWNrdXAvc3Jj
L2xpbnV4L3NjcmlwdHMvbHhkaWFsb2cvTWFrZWZpbGUJVHVlIEp1bCAgMyAw
Njo1NjoyOCAyMDAxDQpAQCAtNCwyICs0LDIgQEANCi1pZmVxICgvdXNyL2lu
Y2x1ZGUvbmN1cnNlcy9uY3Vyc2VzLmgsICQod2lsZGNhcmQgL3Vzci9pbmNs
dWRlL25jdXJzZXMvbmN1cnNlcy5oKSkNCi0gICAgICAgIEhPU1RDRkxBR1Mg
Kz0gLUkvdXNyL2luY2x1ZGUvbmN1cnNlcyAtRENVUlNFU19MT0M9IjxuY3Vy
c2VzLmg+Ig0KK2lmZXEgKC91c3IvbG9jYWwvaW5jbHVkZS9uY3Vyc2VzLmgs
ICQod2lsZGNhcmQgL3Vzci9sb2NhbC9pbmNsdWRlL25jdXJzZXMuaCkpDQor
ICAgICAgICBIT1NUQ0ZMQUdTICs9IC1JL3Vzci9sb2NhbC9pbmNsdWRlIC1E
Q1VSU0VTX0xPQz0iPG5jdXJzZXMuaD4iDQpAQCAtNywyICs3LDIgQEANCi1p
ZmVxICgvdXNyL2luY2x1ZGUvbmN1cnNlcy9jdXJzZXMuaCwgJCh3aWxkY2Fy
ZCAvdXNyL2luY2x1ZGUvbmN1cnNlcy9jdXJzZXMuaCkpDQotICAgICAgICBI
T1NUQ0ZMQUdTICs9IC1JL3Vzci9pbmNsdWRlL25jdXJzZXMgLURDVVJTRVNf
TE9DPSI8bmN1cnNlcy9jdXJzZXMuaD4iDQoraWZlcSAoL3Vzci9sb2NhbC9p
bmNsdWRlL2N1cnNlcy5oLCAkKHdpbGRjYXJkIC91c3IvbG9jYWwvaW5jbHVk
ZS9jdXJzZXMuaCkpDQorICAgICAgICBIT1NUQ0ZMQUdTICs9IC1JL3Vzci9s
b2NhbC9pbmNsdWRlIC1EQ1VSU0VTX0xPQz0iPGN1cnNlcy5oPiINCkBAIC0x
MCArMTAgQEANCi1pZmVxICgvdXNyL2luY2x1ZGUvbmN1cnNlcy5oLCAkKHdp
bGRjYXJkIC91c3IvaW5jbHVkZS9uY3Vyc2VzLmgpKQ0KK2lmZXEgKC91c3Iv
bG9jYWwvaW5jbHVkZS9uY3Vyc2VzLmgsICQod2lsZGNhcmQgL3Vzci9sb2Nh
bC9pbmNsdWRlL25jdXJzZXMuaCkpDQo=
--747458502-1378787805-994161538=:16796--
