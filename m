Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316496AbSEJN1L>; Fri, 10 May 2002 09:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSEJN1K>; Fri, 10 May 2002 09:27:10 -0400
Received: from 216-220-240-114.midmaine.com ([216.220.240.114]:5381 "EHLO
	server.superrealty.com") by vger.kernel.org with ESMTP
	id <S316491AbSEJN1H>; Fri, 10 May 2002 09:27:07 -0400
Message-ID: <C144D032EA60D3119AAC00105A75C19A11AB20@SERVER>
From: Brian Raymond <padrino121@email.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-ppp@vger.kernel.org'" <linux-ppp@vger.kernel.org>,
        "'linux-net@vger.kernel.org'" <linux-net@vger.kernel.org>
Subject: mc_forwarding Option in sys.net.ipv4.conf.all
Date: Fri, 10 May 2002 09:25:55 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly support question, send to kernel list because of confusion with
mc_forwarding being set as read only.

I've been working on a Linux PPTP VPN server for clients that require
multicasting. I only have one physical interface in the box and I'm using
the PoPToP package for PPTP support. Getting the VPN setup and working
hasn't been a problem, getting the multicast traffic to flow between the ppp
and eth0 interface is causing me a whole lot of problems. What do I need to
do so that I can tell the kernel to forward all relevant multicast traffic
through to the clients (in essence just a simple IGMP router)? I've been
looking at mrouted, pimd-dense and mrtd but haven't had any luck getting
them to work because of the dynamic nature of the PPP interfaces.

My backup is a W2K server which I've had some luck getting to work but I
would really hate to use it unless I need to because there is a huge
political battle raging right now about Linux being a sub standard OS.

Thanks.

Brian Raymond

