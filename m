Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281162AbRKPSjH>; Fri, 16 Nov 2001 13:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281473AbRKPSi6>; Fri, 16 Nov 2001 13:38:58 -0500
Received: from [208.232.58.25] ([208.232.58.25]:31667 "EHLO kronos.usol.com")
	by vger.kernel.org with ESMTP id <S281478AbRKPSiu>;
	Fri, 16 Nov 2001 13:38:50 -0500
Subject: Kernel oops with XF86
From: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Q0O82PnpJmRj1UCba8zz"
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 16 Nov 2001 13:37:44 -0500
Message-Id: <1005935864.3309.0.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q0O82PnpJmRj1UCba8zz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Running kernel 2.4.15-pre5, XFree86 4.1 with a Savage4 based
(SavageTwister) video card, a Via 82C686b based motherboard, Mobile
Duron processor, I got the attached kernel oops.  I was running Xine,
with the XShm video output, and the null audio output.  The movie
started playing, then the system "locked up."  When I rebooted, I found
that message in /var/log/messages.

If there's anything else I need to supply for this bug report, lemme
know.  And I'm more than willing to test patches if that's wanted of
me.  ^,^

Also, I'm not on the last, so make sure I get a copy of any replies.

Thanks!
Sean Etc.







--=-Q0O82PnpJmRj1UCba8zz
Content-Disposition: attachment; filename=crash-oops.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

Nov 16 13:22:44 novalayer kernel:  printing eip:
Nov 16 13:22:44 novalayer kernel: c01393c9
Nov 16 13:22:44 novalayer kernel: Oops: 0000
Nov 16 13:22:44 novalayer kernel: CPU:    0
Nov 16 13:22:44 novalayer kernel: EIP:    0010:[poll_freewait+25/68]    Not=
 tainted
Nov 16 13:22:44 novalayer kernel: EFLAGS: 00210286
Nov 16 13:22:44 novalayer kernel: eax: cc7edf6c   ebx: ffffffe8   ecx: cc7e=
df6c   edx: cc7ec000
Nov 16 13:22:44 novalayer kernel: esi: ca99b000   edi: ca99b008   ebp: cc7e=
df74   esp: cc7edf34
Nov 16 13:22:44 novalayer kernel: ds: 0018   es: 0018   ss: 0018
Nov 16 13:22:44 novalayer kernel: Process XFree86 (pid: 573, stackpage=3Dcc=
7ed000)
Nov 16 13:22:45 novalayer kernel: Stack: 00000000 cb190f20 00000000 c01396e=
8 cc7edf6c 00000020 00000008 cefcf940=20
Nov 16 13:22:45 novalayer kernel:        00000304 00100000 cc7ec000 000028f=
a 00000015 00000000 00000000 ca99b000=20
Nov 16 13:22:45 novalayer kernel:        00000000 c0139a4a 00000015 cc7edfa=
8 cc7edfa4 cc7ec000 00000000 bffff674=20
Nov 16 13:22:45 novalayer kernel: Call Trace: [do_select+452/476] [sys_sele=
ct+802/1124] [system_call+51/56]=20
Nov 16 13:22:45 novalayer kernel:=20
Nov 16 13:22:45 novalayer kernel: Code: 8b 43 14 8d 53 04 e8 98 8e fd ff 8b=
 03 e8 5d 4e ff ff 39 fb=20

--=-Q0O82PnpJmRj1UCba8zz--

