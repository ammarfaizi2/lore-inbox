Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135562AbRAHLIe>; Mon, 8 Jan 2001 06:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136983AbRAHLIO>; Mon, 8 Jan 2001 06:08:14 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:46324 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S132903AbRAHLHl>; Mon, 8 Jan 2001 06:07:41 -0500
Date: Mon, 8 Jan 2001 11:06:41 +0000 (GMT)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 - small success
Message-ID: <Pine.GSO.4.21.0101081057380.25031-100000@acms23>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

Just to add a spoonful of honey to what seems to be a flood of criticism
and bug-reports on 2.4.0: installed it (final) on a P75 with an S3-Trio64
graphics card, CS4232 sound card without any problem whatsoever (apart,
perhaps, from some compile warnings - but those are supposedly due to an
UNRECOMMENDED compiler gcc-2.95.2). Modem and Zip also work fine. However,
unfortunately, my hopes that 2.4.0 will somehow miraculously allow me to
use IDE bus-mastering on PIIX did not come true:-(

Some further notes, for those interested:-) CS4232 now works as a module -
was not able to do this with 2.2.x, wvdial (SuSE's Internet dial-up
program) doesn't work without a small hack - pppd dies, because the module
ppp0 (I think), sought for by wvdial (?) no longer exists. By if you
manually load 2.4.0 ppp modules - everything works fine.

Thanks to all!
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
