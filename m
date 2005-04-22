Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVDVOoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVDVOoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 10:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVDVOon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 10:44:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37321 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261950AbVDVOod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 10:44:33 -0400
Subject: Re: nVidia stuff again
From: Arjan van de Ven <arjan@infradead.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1114118223l.10060l.0l@werewolf.able.es>
References: <1113341579.3105.63.camel@caveman.xisl.com>
	 <425CEAC2.1050306@aitel.hist.no>
	 <20050413125921.GN17865@csclub.uwaterloo.ca>
	 <20050413130646.GF32354@marowsky-bree.de>
	 <20050413132308.GP17865@csclub.uwaterloo.ca> <425D3924.1070809@nortel.com>
	 <425E77BB.5010902@aitel.hist.no>
	 <1114021024.26866.63.camel@compaq-rhel4.xsintricity.com>
	 <21d7e997050420161234141e23@mail.gmail.com>
	 <1114085702.26866.137.camel@compaq-rhel4.xsintricity.com>
	 <20050421133554.GU17865@csclub.uwaterloo.ca> <4267BC1C.1050801@kromtek.com>
	 <1114118223l.10060l.0l@werewolf.able.es>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 16:44:25 +0200
Message-Id: <1114181066.10355.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> werewolf:/lib/modules/2.6.11-jam14/kernel/drivers/video# ll
> -rw-rw-r--  1 root root 4402072 Apr 14 23:18 nvidia.ko
> werewolf:/usr/X11R6/lib# ll /usr/X11R6/lib/*7174*
> -rwxr-xr-x  1 root root  485260 Apr 11 01:12 /usr/X11R6/lib/libGL.so.1.0.7174*
> -rwxr-xr-x  1 root root 7626156 Apr 11 01:12 /usr/X11R6/lib/libGLcore.so.1.0.7174*
> 
> 12 Mb of code is too much for a wrapper that just loads the hardware and
> calls a rom ;) What is there ? Runtime loadable microcode ? Specially
> optimized code for sending data to 2 pipes on a GeForce2 and 8 on a 6800 ?
> Who knows. But sure the driver does _many_ things.

this is because they put the entire openGL layer in the kernel (unlike
most open source drivers where the gl layer is in userspace and only the
hw part is in the kernel)


