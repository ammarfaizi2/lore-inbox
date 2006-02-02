Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWBBQS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWBBQS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWBBQS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:18:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:30896 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932109AbWBBQSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:18:25 -0500
Date: Thu, 2 Feb 2006 17:17:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, James@superbug.co.uk, acahalan@gmail.com,
       "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43E0E950.nail46349AMDL@burner>
Message-ID: <Pine.LNX.4.61.0602021715120.13212@yvahk01.tjqt.qr>
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
 <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk>
 <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr> <43DDFBFF.nail16Z3N3C0M@burner>
 <20060130120408.GA8436@merlin.emma.line.org> <43DE3AE5.nail16ZL1UH7X@burner>
 <43DE4055.8090501@pobox.com> <43DE42DD.nail2AM41DPRR@burner>
 <Pine.LNX.4.61.0602011601420.22529@yvahk01.tjqt.qr> <43E0E950.nail46349AMDL@burner>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-125863574-1138897061=:13212"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-125863574-1138897061=:13212
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>
>> I am not sure if I understood your other mail on the cdrecord ML, but if 
>> the proper syntax would be
>>   cdrecord -dev=/dev/hdc:@
>> then
>>   /dev/hdc
>> could just be transparently turned into
>>   /dev/hdc:@
>> somewhere within the getopt part.
>
>See complete description, the :@ is not just for fun....
>

       "If  the name of the device node that has been speci■
       fied on such a system refers to exactly one SCSI device, a shorthand in
       the form dev= devicename:@ or dev= devicename:@,lun may be used instead
       of dev= devicename:scsibus,target,lun."

So @ is equal to 0,0,0 or 0,0?


Threads indicated that every device under linux is "exactly one SCSI device",
which is why I was asking for this behind-the-scenes translation of /dev/hdc
into /dev/hdc:@.

>> for other OS:
>>   cdrecord -dev=/dev/acd0 on FreeBSD
>
>Will not work
>
I think mount uses this syntax (`mount /dev/acd0 /mnt`).



Jan Engelhardt
-- 
--1283855629-125863574-1138897061=:13212--
