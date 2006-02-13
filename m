Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWBMQeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWBMQeV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWBMQeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:34:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:58516 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932125AbWBMQeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:34:20 -0500
Date: Mon, 13 Feb 2006 17:34:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: jerome.lacoste@gmail.com, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43F0B2BA.nailKUS1DNTEHA@burner>
Message-ID: <Pine.LNX.4.61.0602131732190.24297@yvahk01.tjqt.qr>
References: <20060208162828.GA17534@voodoo> <43EC887B.nailISDGC9CP5@burner>
 <200602090757.13767.dhazelton@enter.net> <43EC8F22.nailISDL17DJF@burner>
 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
 <43F06220.nailKUS5D8SL2@burner> <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
 <43F0A010.nailKUSR1CGG5@burner> <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com>
 <43F0AA83.nailKUS171HI4B@burner> <5a2cf1f60602130805u537de206k22fa418ee214cf02@mail.gmail.com>
 <43F0B2BA.nailKUS1DNTEHA@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.61.0602131734051.24297@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The information printed will be printed in a format such as:
>>
>> b,t,l <= os_specific_name
>
>Why do you believe that this kind of mapping is needed?
>

Assume the user has a /dev/white_dvd and a /dev/black_dvd, both of being 
the same brand. `cdrecord -scanbus` would return sth like

scsibus0:
        0,0,0     0) *
        0,1,0     1) 'HL-DT-ST' 'DVDRAM GSA-4160B' 'A301' Removable CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
scsibus1:
        1,0,0     0) *
        1,1,0     1) 'HL-DT-ST' 'DVDRAM GSA-4160B' 'A301' Removable CD-ROM
        1,2,0     2) *
        1,3,0     3) *
        1,4,0     4) *
        1,5,0     5) *
        1,6,0     6) *
        1,7,0     7) *

probably. But how to find out from the btl which one is the black and which 
one is the white one?


Jan Engelhardt
-- 
