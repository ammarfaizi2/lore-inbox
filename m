Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135820AbRDTGbG>; Fri, 20 Apr 2001 02:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135819AbRDTGa4>; Fri, 20 Apr 2001 02:30:56 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:18441 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135818AbRDTGas>;
	Fri, 20 Apr 2001 02:30:48 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15071.55140.367276.726470@argo.ozlabs.ibm.com.au>
Date: Fri, 20 Apr 2001 16:29:56 +1000 (EST)
To: "Manfred H. Winter" <mahowi@gmx.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.3] PPP errors
In-Reply-To: <20010404021554.A1596@marvin.mahowi.de>
In-Reply-To: <20010404021554.A1596@marvin.mahowi.de>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred H. Winter writes:

> Apr  4 02:05:21 marvin pppd[1227]: Plugin /usr/lib/passwordfd.so loaded.
> Apr  4 02:05:21 marvin pppd[1227]: pppd 2.4.0 started by mahowi, uid 500
> Apr  4 02:05:21 marvin pppd[1227]: Perms of /dev/ttyS0 are ok, no 'mesg n' necce
> sary.

Just out of curiosity, what pppd are you running, with what patches?
I don't recognize the message about 'perms of /dev/ttyS0'.
Or does this message come from the passwordfd.so plugin?

> Modules Loaded         serial sb sb_lib uart401 isa-pnp NVdriver opl3 sound soundcore ipt_MASQUERADE iptable_nat ip_conntrack ppp_generic slhc iptable_filter ip_tables af_packet khttpd autofs4 unix 8139too ide-scsi aic7xxx scsi_mod

No ppp_async loaded - that's the problem.

Paul.
