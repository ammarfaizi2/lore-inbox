Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbTCaAat>; Sun, 30 Mar 2003 19:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbTCaAat>; Sun, 30 Mar 2003 19:30:49 -0500
Received: from c-30a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.48]:47559
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP
	id <S261339AbTCaAas>; Sun, 30 Mar 2003 19:30:48 -0500
To: linux-kernel@vger.kernel.org
Subject: assertion failed in tcp.c & af_inet.c
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 31 Mar 2003 02:41:39 +0200
Message-ID: <yw1xy92wxt8c.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I keep getting these messages in the kernel log:

KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689)

It seems to be related to accepting an incoming connection.

The kernel is 2.4.21-pre4 on Alpha.  The machine is behind a firewall
that forwards connections so some ports to this machine.

-- 
Måns Rullgård
mru@users.sf.net
