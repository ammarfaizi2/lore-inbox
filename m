Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318838AbSG0WWX>; Sat, 27 Jul 2002 18:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318840AbSG0WWX>; Sat, 27 Jul 2002 18:22:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:18161 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318838AbSG0WWW>; Sat, 27 Jul 2002 18:22:22 -0400
Subject: RE: About the need of a swap area
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Buddy Lumpkin <b.lumpkin@attbi.com>
Cc: Austin Gonyou <austin@digitalroadkill.net>,
       vda@port.imtp.ilyichevsk.odessa.ua, Ville Herva <vherva@niksula.hut.fi>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <FJEIKLCALBJLPMEOOMECOEPFCPAA.b.lumpkin@attbi.com>
References: <FJEIKLCALBJLPMEOOMECOEPFCPAA.b.lumpkin@attbi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 Jul 2002 00:40:11 +0100
Message-Id: <1027813211.21516.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-27 at 23:22, Buddy Lumpkin wrote:
> I thought linux worked more like Solaris where it didn't use any swap (AT
> ALL) until it has to... At least, I hope linux works this way.

I'd be suprised if Solaris did something that dumb.

You want to push out old long unaccessed pages of code to make room for
more cached disk blocks from files.

