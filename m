Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267720AbSLTGGg>; Fri, 20 Dec 2002 01:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267727AbSLTGGg>; Fri, 20 Dec 2002 01:06:36 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:17047 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S267720AbSLTGGf>; Fri, 20 Dec 2002 01:06:35 -0500
Date: Fri, 20 Dec 2002 07:14:36 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre2 assertion errer in af_inet.c/tcp.c
Message-ID: <20021220061436.GD3997@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From my syslog this night:

Dec 20 05:46:59 hummus kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
Dec 20 05:46:59 hummus kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689)
Dec 20 05:46:59 hummus kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
Dec 20 05:46:59 hummus kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689)
Dec 20 05:56:24 hummus kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
Dec 20 05:56:24 hummus kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689)
Dec 20 05:56:24 hummus kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
Dec 20 05:56:24 hummus kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689)

Linux hummus 2.4.21-pre2 #1 Thu Dec 19 00:16:41 CET 2002 i686 unknown unknown GNU/Linux

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
Now that we know Microsoft's plan for world domination isn't superman
suppost to come out and kick some ass? 

