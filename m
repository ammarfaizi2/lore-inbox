Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273971AbRIRXyP>; Tue, 18 Sep 2001 19:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273974AbRIRXyF>; Tue, 18 Sep 2001 19:54:05 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:49131 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S273971AbRIRXx4>; Tue, 18 Sep 2001 19:53:56 -0400
Message-ID: <3BA7DEA1.3E6A38A5@kegel.com>
Date: Tue, 18 Sep 2001 16:54:09 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [LUSER] Re: ext3/ext2 compatibility; time for ext3 in mainline kernel?
In-Reply-To: <E15jOBz-0001FT-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I installed Red Hat 7.2beta, and chose its nifty ext3 option when
> > setting up my partitions.  But now when I boot into vanilla 2.4.9,
> > some files are mysteriously missing...
> 
> This should definitely work. 

Er, nevermind.  I needed to do
   mount -t ext2 -L /usr /usr

- Dan
