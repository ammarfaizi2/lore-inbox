Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271673AbRIOBYg>; Fri, 14 Sep 2001 21:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271677AbRIOBYR>; Fri, 14 Sep 2001 21:24:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42255 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271673AbRIOBYK>; Fri, 14 Sep 2001 21:24:10 -0400
Subject: Re: ISOFS corrupt filesizes
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 15 Sep 2001 02:28:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9nu8sv$fnj$1@cesium.transmeta.com> from "H. Peter Anvin" at Sep 14, 2001 05:54:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15i4GM-0001Iw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1 GB comes from the fact that some old CD's actually put garbage in
> the upper byte of the file size, so the test triggers if the size is
> larger than any CD can be.  Unfortunately, DVDs are a lot bigger than
> CDs and that assumption is no longer correct.

DVD is supposed to be using 1Gb files. I don't think its a big issue as
we support UDF too
