Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSKDMWx>; Mon, 4 Nov 2002 07:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264661AbSKDMWw>; Mon, 4 Nov 2002 07:22:52 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:51855 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264659AbSKDMWw>; Mon, 4 Nov 2002 07:22:52 -0500
Subject: Re: Troubles with Sony PCG-C1MHP (crusoe based and ALIM 1533
	drivers)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cjtsai@ali.com.tw, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <20021104114912.7c1282fa.Manuel.Serrano@sophia.inria.fr>
References: <20021104114912.7c1282fa.Manuel.Serrano@sophia.inria.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 12:50:47 +0000
Message-Id: <1036414247.1113.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 10:54, Manuel Serrano wrote:
> -----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
> ALI15X3: chipset revision 196
> ALI15X3: IDE controller on PCI bus 00 dev 80
> ALI15X3: not 100% native mode: will probe irqs later
> -----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
> 
> Nothing more. At this point, the keyboard is ineffective. The only solution
> is to switch off the computer.

Should be fixed in the development tree already. Forcing ata66 might
also make the problem go away. The ALi code in the existing kernels
assumes ALi north and south bridges so comes apart completely on the
crusoe boxes which have a transmeta virtual northbridge on the
CPU/software itself.


