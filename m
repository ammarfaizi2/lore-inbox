Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315163AbSD2TbR>; Mon, 29 Apr 2002 15:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315165AbSD2TbQ>; Mon, 29 Apr 2002 15:31:16 -0400
Received: from brussels-smtp.planetinternet.be ([195.95.34.12]:43538 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S315163AbSD2TbQ>; Mon, 29 Apr 2002 15:31:16 -0400
Date: Mon, 29 Apr 2002 21:31:57 +0200
From: Leopold Gouverneur <lgouv@pi.be>
To: linux-kernel@vger.kernel.org
Subject: IDE and HPT366 Some results
Message-ID: <20020429193157.GA2124@gouv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I don't know if this is of interest:
 hda on PIIX4, hde on HTP366 udma3

 kernel 2.5.8 : 
 hdparm -t /dev/hda 9,5MB/sec (as usual)
 hdparm -t /dev/hde 30MB/sec (best so far)

 kernel 2.5.9 :
 not tried

 kernel 2.5.10 :
 crashing during boot  probing hde

 kernel 2.5.11 :
 hdparm -t /dev/hda 9,5 MB/sec
 hdparm -t /dev/hde 15 MB/sec ( never got less than 25 in the past )

 BTW 2.5.11 will not compile for me if sound support is
 enabled (gcc3.0.4), complaining about KERN_ERR not defined
 
