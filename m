Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319830AbSIMXpL>; Fri, 13 Sep 2002 19:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319831AbSIMXpL>; Fri, 13 Sep 2002 19:45:11 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:55024
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319830AbSIMXpL> convert rfc822-to-8bit; Fri, 13 Sep 2002 19:45:11 -0400
Subject: Re: ALi M1543 on P200
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?Vladim=EDr?= T =?ISO-8859-1?Q?T=FD?= 
	<druid@mail.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001701c25b59$7756a820$4500a8c0@cybernet.cz>
References: <001701c25b59$7756a820$4500a8c0@cybernet.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 14 Sep 2002 00:51:17 +0100
Message-Id: <1031961077.10099.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 20:12, Vladimír Tøebický wrote:
> I cannot use DMA on my new disks. UDMA is enabled in BIOS in mode UDMA 2. It
> doesn't work even in auto mode. ide0=dma doesn't work either. hdparm -d 1
> /dev/hda causes "operation not permitted"

Known bug in the new IDE code. This one is still pending resolution.

