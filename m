Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTKLDBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 22:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbTKLDBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 22:01:54 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:61657 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261592AbTKLDBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 22:01:50 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Michal Kosmulski <M.Kosmulski@elka.pw.edu.pl>,
       John Bradford <john@grabjohn.com>
Subject: Re: ASUS CD-ROM problem reading CD-RW
Date: Tue, 11 Nov 2003 22:01:46 -0500
User-Agent: KMail/1.5.1
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0311112224550.26013-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0311112224550.26013-100000@mion.elka.pw.edu.pl>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311112201.46020.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.61.203] at Tue, 11 Nov 2003 21:01:49 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 November 2003 16:31, Michal Kosmulski wrote:
>> > I own a 40x ASUS CD-ROM drive CD-S400 (this is an IDE drive but
>> > it runs under ide-scsi).
>>
>> Why do you want to use it with IDE-SCSI?  Why not use it as a
>> native IDE device?
>
>I like k3b and other kde tools dealing with CDs and they require the
> use of ide-scsi at least as far as I know (I tried to use cdrecord
> 2 without ide-scsi with k3b but without success). I use k3b because
> I sometimes use an external usb cd-recorder. However it is
> currently not connected to the system.
>Michal

k3b does indeed allow the use of straight ide access for at least 
kernel 2.6.0-test9-mm2.  I'm running it that way.  Likewise, grip 
seems to be happy as long as /dev/cdrom is a softlink to /dev/hdc.
I'm running both of them that way here.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

