Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSIDXdf>; Wed, 4 Sep 2002 19:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSIDXde>; Wed, 4 Sep 2002 19:33:34 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:14582
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316342AbSIDXdX>; Wed, 4 Sep 2002 19:33:23 -0400
Subject: Re: IDE write speed (Promise versus AMD)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020904195729.A3985@fi.muni.cz>
References: <20020904195729.A3985@fi.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 00:38:35 +0100
Message-Id: <1031182715.2788.144.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 18:57, Jan Kasprzak wrote:
> - it takes about 50 seconds (~40 MByte/s write speed) on hda, hdb and hdc,
> but 2 minutes 48 seconds (~12 MByte/s write speed) on hde, hdf and hdg.
> I have 1 GB of RAM, server is dual athlon 2000+. Kernel is 2.4.20-pre5-ac1.
> 
> 	Is there any problem with the Promise IDE driver on Linux?

One or two with various versions. I've seen the same thing with both IDE
and non IDE devices with the AMD chipset. The two 64bit slots and the
onboard I/O seems to have markedly higher write throughput. 


