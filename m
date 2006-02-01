Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWBAQmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWBAQmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbWBAQmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:42:43 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:62138 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161103AbWBAQmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:42:42 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 01 Feb 2006 17:41:02 +0100
To: schilling@fokus.fraunhofer.de, htejun@gmail.com
Cc: psusi@cfl.rr.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <43E0E49E.nail4632YYWNF@burner>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <43DCA097.nailGPD11GI11@burner>
 <20060129112613.GA29356@merlin.emma.line.org>
 <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr>
 <43DD2A8A.nailGVQ115GOP@burner>
 <787b0d920601291328k52191977h37 <43DE495A.nail2BR211K0O@burner>
 <43DE75F5.40900@cfl.rr.com> <43DF403F.nail2RF310RP6@burner>
 <43E0671F.1010302@gmail.com>
In-Reply-To: <43E0671F.1010302@gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:

> So, let's meet somewhere inbetween.  Reserving a SCSI bus number for 
> ATAPI devices and generating ID/LUN for SG_IO devices isn't very 
> difficult and probably a good thing to have.  So, unfortunately, we 
> won't have pretty /dev/sg* for all SCSI-aware devices, but you only have 
> to scan limited number of devices - /dev/sg* and /dev/hd*.

libscg already has to deal with this kind of problems (see /dev/pg*).

You can't add work arounds ad nauseum.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
