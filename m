Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSJ2Er0>; Mon, 28 Oct 2002 23:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSJ2Er0>; Mon, 28 Oct 2002 23:47:26 -0500
Received: from alpha8.cc.monash.edu.au ([130.194.1.8]:43269 "EHLO
	ALPHA8.CC.MONASH.EDU.AU") by vger.kernel.org with ESMTP
	id <S261550AbSJ2ErZ>; Mon, 28 Oct 2002 23:47:25 -0500
Date: Tue, 29 Oct 2002 14:39:59 +1100 (EST)
From: netdev-bounce@oss.sgi.com
To: undisclosed-recipients:;
Message-id: <20021029033959.B76CD12CE75@blammo.its.monash.edu.au>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The e1000 can very well do hardware checksumming on transmit.
>
> The missing piece of the puzzle is that his application is not
> using sendfile(), without which no transmit checksum offload
> can take place.

As far as I've understood, sendfile() won't do much good with large files. Is 
this right?

We're talking of 3-6GB files here ...

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.



