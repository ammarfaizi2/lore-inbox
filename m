Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135843AbRDYMXK>; Wed, 25 Apr 2001 08:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135846AbRDYMWu>; Wed, 25 Apr 2001 08:22:50 -0400
Received: from p3EE3C739.dip.t-dialin.net ([62.227.199.57]:39689 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135843AbRDYMUd>; Wed, 25 Apr 2001 08:20:33 -0400
Date: Wed, 25 Apr 2001 14:20:31 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.3-ac14
Message-ID: <20010425142030.A10210@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <E14sCGz-0003D4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14sCGz-0003D4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 25, 2001 at 00:31:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, Alan Cox wrote:

> 2.4.3-ac10
> o	Fix reboot notifier unregister in aic7xxx	(Arjan van de Ven)

> 2.4.3-ac6
> o	Merge aic7xxx driver 6.11			(Justin Gibbs)

I tried vanilla 2.4.3 yesterday, on a box which has one DPTA (IDE) drive
and two Seagate SCSI drives along with a CD-ROM attached to some 2940.
Linux 2.2.19 is fine on that box, but 2.4.3 tells something about an
abort that returned some value and fails to detect what Linux 2.2 calls
/dev/sda. Reset -> Inquiry delay in kernel is 10,000 ms.

Does any of the aforementioned merges remedy detection problems or
should I try a current 2.4.3-ac version and file a full report in case
the problem persists?
