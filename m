Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285336AbRLSP4K>; Wed, 19 Dec 2001 10:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285337AbRLSP4A>; Wed, 19 Dec 2001 10:56:00 -0500
Received: from dnph.phys.msu.su ([193.232.121.81]:39697 "HELO dnph.phys.msu.su")
	by vger.kernel.org with SMTP id <S285336AbRLSPzo>;
	Wed, 19 Dec 2001 10:55:44 -0500
Content-Type: text/plain;
  charset="koi8-r"
From: Oleg Artamonov <oleg@dnph.phys.msu.su>
Organization: Moscow State University, Department of Nuclear Physics
To: Thomas Deselaers <thomas@deselaers.de>, linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Date: Wed, 19 Dec 2001 18:55:38 +0300
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de>
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011219155538.BF29F3B92@dnph.phys.msu.su>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Deselaers написал:
> /dev/hdc:
>  Timing buffered disk reads:  64 MB in  5.63 seconds = 11.37 MB/sec
>
> What would be a value I can expect from my hardware?

  I have a Maxtor D541X (20Gbytes, 5400rpm), and its results are about 
37MB/sec... Motherboard is Epox 8KTA3 with VIA 686B southbridge (HDD runs in 
UDMA5 mode).

> And what might result in higher speeds?

  Did you enable UltraDMA2 (P2B-S supports only UDMA2, not UDMA4 nor UDMA5)? 
32-bit transfer? What 'hdparm /dev/hda' and 'hdpram -i /dev/hda' says?
