Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbSLQOtG>; Tue, 17 Dec 2002 09:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSLQOtG>; Tue, 17 Dec 2002 09:49:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11746
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265081AbSLQOtF>; Tue, 17 Dec 2002 09:49:05 -0500
Subject: Re: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (21/21)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DFDE4FE.755F6651@cinet.co.jp>
References: <3DFC50E9.656B96D0@cinet.co.jp> <3DFC818F.80E3DC00@cinet.co.jp>
	<20021215.225942.24871004.yoshfuji@linux-ipv6.org> 
	<3DFDE4FE.755F6651@cinet.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 15:36:49 +0000
Message-Id: <1040139409.20199.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any chance of moving the EBDA to query to be something like

	unsigned long get_bios_ebda(void)

and hiding it in the per platform includes (returning 0 for non I guess)

