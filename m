Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSHZM1l>; Mon, 26 Aug 2002 08:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSHZM1l>; Mon, 26 Aug 2002 08:27:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39419 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318122AbSHZM1l>; Mon, 26 Aug 2002 08:27:41 -0400
Subject: Re: ATA err with 2.4.20-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020826141404.3a73e8ed.Gregor.Fajdiga@telemach.net>
References: <20020826103525.7817bb4e.Gregor.Fajdiga@telemach.net>
	<1030355630.16767.30.camel@irongate.swansea.linux.org.uk> 
	<20020826141404.3a73e8ed.Gregor.Fajdiga@telemach.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 13:33:11 +0100
Message-Id: <1030365191.1437.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 13:14, Grega Fajdiga wrote:
> hda: 20010816 sectors (10246 MB) w/512KiB Cache, CHS=1245/255/63, UDMA(33)
> hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: task_no_data_intr: error=0x04 { DriveStatusError }
> hdb: 3329424 sectors (1705 MB) w/128KiB Cache, CHS=825/64/63, UDMA(33)

Ok thats fine. Eventually we can quieten down results from commands we
throw at the drive which we know it might not want.

