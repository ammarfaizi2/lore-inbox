Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274675AbRJFJPx>; Sat, 6 Oct 2001 05:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274674AbRJFJPo>; Sat, 6 Oct 2001 05:15:44 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:64530 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S274671AbRJFJPf>; Sat, 6 Oct 2001 05:15:35 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [POT] Which journalised filesystem ?
Date: Sat, 6 Oct 2001 09:16:04 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9pmi4k$95l$1@ncc1701.cistron.net>
In-Reply-To: <m1669uyuqy.fsf@frodo.biederman.org> <E15pbX5-0007do-00@calista.inka.de> <9plgfn$6kq$2@ncc1701.cistron.net> <1002357150.3083.20.camel@volk.internalnet>
X-Trace: ncc1701.cistron.net 1002359764 9397 195.64.65.67 (6 Oct 2001 09:16:04 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1002357150.3083.20.camel@volk.internalnet>,
Tonu Samuel  <tonu@please.do.not.remove.this.spam.ee> wrote:
>On Sat, 2001-10-06 at 01:41, Miquel van Smoorenburg wrote:
>> >Does that mean we can or we can't? Is there a flush write cache operation in
>> >ATA? I asume there is one in SCSI?
>> 
>> Well hdparm has a -W option with which you can turn on/off the
>> write cache. If that works (and it appears it does) you should be
>> able to turn write cache off, write *one* block so that the
>> cache gets flushed and turn it back on. I'm not sure how to
>> test this, though.
>
>Doesn't hdparm -W0f do the work?

No, -f flushes the kernels buffer cache, not the IDE disk write cache.

Mike.
-- 
Move sig.

