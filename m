Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbWBAPeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWBAPeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422632AbWBAPeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:34:16 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2764 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422635AbWBAPeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:34:15 -0500
Date: Wed, 1 Feb 2006 16:34:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <58cb370e0601310623ic220d27q3bfd4642cd0538fb@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0602011630440.22529@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> 
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>  <43D7B1E7.nailDFJ9MUZ5G@burner>
  <20060125230850.GA2137@merlin.emma.line.org>  <43D8C04F.nailE1C2X9KNC@burner>
 <43DDFBFF.nail16Z3N3C0M@burner>  <1138642683.7404.31.camel@juerg-pd.bitron.ch>
  <43DF3C3A.nail2RF112LAB@burner>  <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com>
  <43DF678E.nail3B431CUWJ@burner> <58cb370e0601310623ic220d27q3bfd4642cd0538fb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> This is called integration and it is done by Linux e.g. for 1394 and USB SCSI
>> devices. So why not for ATAPI?
>
>Because we have native drivers which do not require SCSI stack et all.
>
>* if [ED: it] is very useful if cd-writing can be done with ide-cd and without
>  SCSI stack (a hack but very useful one)
>* you don't need SCSI stack (a lot of code saved!)


Which unfortunately leads us back to one of the early questions.

If ATAPI is some sort of SCSI [command set] over ATA, and ide-cd can be used
without the "Big Bad" SCSI layer (CONFIG_SCSI), don't we have redundant code
floating around?



Jan Engelhardt
-- 
