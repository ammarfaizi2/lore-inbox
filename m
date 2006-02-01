Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWBAPma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWBAPma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWBAPma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:42:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14278 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161076AbWBAPma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:42:30 -0500
Date: Wed, 1 Feb 2006 16:37:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Oliver Neukum <oliver@neukum.org>,
       jerome lacoste <jerome.lacoste@gmail.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, j@bitron.ch,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <200601311444.47199.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61.0602011634520.22529@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
 <200601311333.36000.oliver@neukum.org> <200601311444.47199.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > If it's /dev/cdrw, then it's /dev/cdrw, not '1,0,0'.
>> > 
>> > Should we make a poll ?

select(), poll(), epoll(), anyone? (SCNR)

>Do we need to expose IDE master/slave, primary/secondary concepts in Linux?
>
AFAICS, we do. hda is always primary slave, etc. With the SCSI layer it's
(surprisingly) the other way round, sda just happens to be the first disk
inserted (SCA, USB, etc.)


Jan Engelhardt
-- 
