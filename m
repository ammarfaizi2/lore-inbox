Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132725AbRDDATs>; Tue, 3 Apr 2001 20:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132726AbRDDATo>; Tue, 3 Apr 2001 20:19:44 -0400
Received: from pop.gmx.net ([194.221.183.20]:17305 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S132725AbRDDATS>;
	Tue, 3 Apr 2001 20:19:18 -0400
Date: Wed, 4 Apr 2001 02:15:54 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [2.4.3] PPP errors
Message-ID: <20010404021554.A1596@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I still get from time to time the following errors when trying to use
ppp:

Apr  4 02:05:21 marvin pppd[1227]: Plugin /usr/lib/passwordfd.so loaded.
Apr  4 02:05:21 marvin pppd[1227]: pppd 2.4.0 started by mahowi, uid 500
Apr  4 02:05:21 marvin pppd[1227]: Perms of /dev/ttyS0 are ok, no 'mesg n' necce
sary.
Apr  4 02:05:21 marvin pppd[1227]: Couldn't set tty to PPP discipline: Invalid a
rgument
Apr  4 02:05:21 marvin pppd[1227]: Exit.

+++

ver_linux output:
Linux marvin 2.4.3 #3 Sun Apr 1 19:01:20 CEST 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.10s
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0j
PPP                    2.4.0
Linux C Library        x    1 root     root      1382179 Jan 19 07:14 /lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         serial sb sb_lib uart401 isa-pnp NVdriver opl3 sound soundcore ipt_MASQUERADE iptable_nat ip_conntrack ppp_generic slhc iptable_filter ip_tables af_packet khttpd autofs4 unix 8139too ide-scsi aic7xxx scsi_mod

+++

I didn't change my ppp configuration for months so I think it's a kernel 
problem.

Bye,

Manfred
-- 
 /"\                        | PGP-Key available at Public Key Servers
 \ /  ASCII ribbon campaign | or at "http://www.mahowi.de/"
  X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
 / \  and postings          | GPG: 0x88BC3576 * ICQ: 61597169
