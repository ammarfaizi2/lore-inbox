Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWBARCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWBARCp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbWBARCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:02:45 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:33984 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1422648AbWBARCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:02:44 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 01 Feb 2006 18:01:04 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, James@superbug.co.uk, acahalan@gmail.com,
       "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E0E950.nail46349AMDL@burner>
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
In-Reply-To: <Pine.LNX.4.61.0602011601420.22529@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> The user should use what the OS uses. Cdrecord, or libscg, respectively, 
> can invent any numbers it wants. IOW, "we" (read: I) would like to see
>   cdrecord -dev=/dev/hdc on Linux

Unsupported

> I am not sure if I understood your other mail on the cdrecord ML, but if 
> the proper syntax would be
>   cdrecord -dev=/dev/hdc:@
> then
>   /dev/hdc
> could just be transparently turned into
>   /dev/hdc:@
> somewhere within the getopt part.

See complete description, the :@ is not just for fun....

> for other OS:
>   cdrecord -dev=/dev/acd0 on FreeBSD

Will not work

>   cdrecord -dev=E: on Win32

Will only wbe doable with mapping effort in a few cases.

>     cdrecord -dev=\\cdrom0 if someone really wants for Win32

	cdrecord dev=cdrom0 	works on Solaris because "cdrom0"
				is a valid nick name for the drive.

>   cdrecord -dev=/dev/c0t0s0d0 on Solaris

May work sometimes.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
