Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSFDPXR>; Tue, 4 Jun 2002 11:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSFDPXN>; Tue, 4 Jun 2002 11:23:13 -0400
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:49802
	"HELO tabriel.tabris.net") by vger.kernel.org with SMTP
	id <S313087AbSFDPXM>; Tue, 4 Jun 2002 11:23:12 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: tabris <tabris@tabris.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Failure report: tulip driver
Date: Tue, 4 Jun 2002 11:23:07 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.44.0206041555020.1201-100000@grignard>
Cc: Rasmus =?iso-8859-1?q?B=F8g=20Hansen?= <moffe@amagerkollegiet.dk>,
        jgarzik@mandrakesoft.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020604152307.B8D81FB911@tabriel.tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 June 2002 10:18, Rasmus Bøg Hansen wrote:
> [1.] One line summary of the problem:
>
> tulip.o gives transmit timeouts and a reboot is needed.

I'd like to say I reported this same problem a couple months ago...

1) I think it might be partly a timing/temperature issue.

2) it is possible to recover simply by ifdown the interfaces, then rmmod 
the module (assuming it is compiled as module...), then ifup the ifaces 
again.

3) I'm cc'ing this to Jeff Garzik, as I think he is the current 
maintainer of the tulip driver.

--
tabris
