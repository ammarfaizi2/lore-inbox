Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283582AbRLDWXx>; Tue, 4 Dec 2001 17:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283561AbRLDWXo>; Tue, 4 Dec 2001 17:23:44 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:46484 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S283567AbRLDWXb>;
	Tue, 4 Dec 2001 17:23:31 -0500
Date: Tue, 4 Dec 2001 17:23:19 -0500
Subject: Re: HPT370 (KT7A-RAID) *corrupts* data - SAMSUNG SV8004H does it as well
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: linux-kernel@vger.kernel.org
To: Ville Herva <vherva@viasys.com>
From: Anthony DeRobertis <asd@suespammers.org>
In-Reply-To: <20011201115803.B10839@viasys.com>
Message-Id: <8519E629-E905-11D5-828E-00039355CFA6@suespammers.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.475)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Setup here is:

hde: WDC WD200EB-00BHF0, ATA DISK drive
hdg: WDC WD200EB-00BHF0, ATA DISK drive

hde: 39102336 sectors (20020 MB) w/2048KiB Cache, 
CHS=38792/16/63, UDMA(100)
hdg: 39102336 sectors (20020 MB) w/2048KiB Cache, 
CHS=38792/16/63, UDMA(100)

5GB of each in RAID0 on /dev/md/2

cat /dev/md/2 | md5sum now done its fourth run; all OK. 
920b175a519b578dcd7862b720eb9efb, if you care ;-)

This is 2.4.6, on a KT7-RAID board.

