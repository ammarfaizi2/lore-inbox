Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWBCLd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWBCLd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWBCLd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:33:57 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:15775 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932461AbWBCLd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:33:56 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 12:32:37 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, James@superbug.co.uk, acahalan@gmail.com,
       "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E33F55.nail5CA4MZAKZ@burner>
References: <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
 <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk>
 <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr>
 <43DDFBFF.nail16Z3N3C0M@burner>
 <20060130120408.GA8436@merlin.emma.line.org>
 <43DE3AE5.nail16ZL1UH7X@burner> <43DE4055.8090501@pobox.com>
 <43DE42DD.nail2AM41DPRR@burner>
 <Pine.LNX.4.61.0602011601420.22529@yvahk01.tjqt.qr>
 <43E0E950.nail46349AMDL@burner>
 <Pine.LNX.4.61.0602021715120.13212@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602021715120.13212@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >
> >> I am not sure if I understood your other mail on the cdrecord ML, but if 
> >> the proper syntax would be
> >>   cdrecord -dev=/dev/hdc:@
> >> then
> >>   /dev/hdc
> >> could just be transparently turned into
> >>   /dev/hdc:@
> >> somewhere within the getopt part.
> >
> >See complete description, the :@ is not just for fun....
> >
>
>        "If  the name of the device node that has been speciâ? 
>        fied on such a system refers to exactly one SCSI device, a shorthand in
>        the form dev= devicename:@ or dev= devicename:@,lun may be used instead
>        of dev= devicename:scsibus,target,lun."
>
> So @ is equal to 0,0,0 or 0,0?

":@" is a shorthand for ":@,0" which is a shorthand for ":@0,0" 

There are cases where you may like to use e.g. ":@,3"

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
