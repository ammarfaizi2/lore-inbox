Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317566AbSHEA15>; Sun, 4 Aug 2002 20:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317570AbSHEA15>; Sun, 4 Aug 2002 20:27:57 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:33018 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317566AbSHEA14>; Sun, 4 Aug 2002 20:27:56 -0400
Subject: Re: 2.4.19: no DMA for IDE with Intel i845e
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1028505657.1545.3.camel@ixodes.goop.org>
References: <1028505657.1545.3.camel@ixodes.goop.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 02:49:03 +0100
Message-Id: <1028512143.15495.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 01:00, Jeremy Fitzhardinge wrote:
> I just rebooted with 2.4.19, and I find that there's no DMA on my ide
> interface, and it is refusing to honour 'hdparm -d1 /dev/hda'. 

I'm slowly working through fixing the new BIOS behaviour. For your case
2.4.19-ac1 ought to do the job. 2.4.19-ac2 fixed it but has some rather
dramatic side effects. 2.4.19-ac3 is a more invasive but more correct
proposed answer..

