Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318291AbSHUNl5>; Wed, 21 Aug 2002 09:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSHUNl5>; Wed, 21 Aug 2002 09:41:57 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:33006 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318289AbSHUNl4>; Wed, 21 Aug 2002 09:41:56 -0400
Subject: Re: 2.4.20-pre2-ac5 Promise PDC20269
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jason C. Pion" <jpion@valhalla.homelinux.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208201845060.10173-100000@valhalla.homelinux.org>
References: <Pine.LNX.4.44.0208201845060.10173-100000@valhalla.homelinux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 14:46:58 +0100
Message-Id: <1029937618.26533.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 03:11, Jason C. Pion wrote:
> ULTRA 66/100/133: Primary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66 operation.
>          Switching to Ultra33 mode.
> Warning: Primary channel requires an 80-pin cable for operation.
> hde reduced to Ultra33 mode.
> hde: host protected area => 1
> hde: 117266688 sectors (60041 MB) w/1820KiB Cache, CHS=116336/16/63, UDMA(133)
> ULTRA 66/100/133: Secondary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66 operation.
>          Switching to Ultra33 mode.
> Warning: Secondary channel requires an 80-pin cable for operation.
> hdg reduced to Ultra33 mode.
> hdg: host protected area => 1
> hdg: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=116336/16/63, UDMA(133)
> Partition check:

Ok that looks like one of the cases for 80pin cable detect came unstuck.
I've added it to the queue to look into

