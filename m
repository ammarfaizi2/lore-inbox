Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285377AbRLSQ3V>; Wed, 19 Dec 2001 11:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285378AbRLSQ3M>; Wed, 19 Dec 2001 11:29:12 -0500
Received: from dnph.phys.msu.su ([193.232.121.81]:33043 "HELO dnph.phys.msu.su")
	by vger.kernel.org with SMTP id <S285377AbRLSQ3C>;
	Wed, 19 Dec 2001 11:29:02 -0500
Content-Type: text/plain;
  charset="koi8-r"
From: Oleg Artamonov <oleg@dnph.phys.msu.su>
Organization: Moscow State University, Department of Nuclear Physics
To: spike@superweb.ca, linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Date: Wed, 19 Dec 2001 19:28:59 +0300
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de> <20011219160143.GA8658@gondor.com> <01121912181304.31762@spikes>
In-Reply-To: <01121912181304.31762@spikes>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011219162859.89976380A@dnph.phys.msu.su>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brendan Pike написал:

> wowie, that is quite slow then. well udma33 mode is probebly why. if
> getting an ata100 offboard card (since i have an ata100 drive) would make
> such a big differance, im all for it. would there be any others reasons for
> such slowness? is udma33 capible of more then 9MB/sec ??

  Yes, of course it's capable. Up to 33Mbytes/sec (really you should see 
about 20Mbytes/sec or more). Sounds like you disable 32-bit transfer or 
disable DMA modes.

> dont know if that info would help much but there it is. also uses the via
> kernel driver.

  What 'hdparm /dev/<your drive>' and 'hdparm -i /dev/<your drive>' says?
