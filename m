Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274611AbRJEXlk>; Fri, 5 Oct 2001 19:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274596AbRJEXlb>; Fri, 5 Oct 2001 19:41:31 -0400
Received: from uucp.cistron.nl ([195.64.68.38]:14609 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S274586AbRJEXlT>;
	Fri, 5 Oct 2001 19:41:19 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [POT] Which journalised filesystem ?
Date: Fri, 5 Oct 2001 23:41:43 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9plgfn$6kq$2@ncc1701.cistron.net>
In-Reply-To: <m1669uyuqy.fsf@frodo.biederman.org> <E15pbX5-0007do-00@calista.inka.de>
X-Trace: ncc1701.cistron.net 1002325303 6810 195.64.65.67 (5 Oct 2001 23:41:43 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15pbX5-0007do-00@calista.inka.de>,
Bernd Eckenfels  <ecki@lina.inka.de> wrote:
>In article <m1669uyuqy.fsf@frodo.biederman.org> you wrote:
>> Definentily.  We want a write-barrier however we can get it.
>
>Does that mean we can or we can't? Is there a flush write cache operation in
>ATA? I asume there is one in SCSI?

Well hdparm has a -W option with which you can turn on/off the
write cache. If that works (and it appears it does) you should be
able to turn write cache off, write *one* block so that the
cache gets flushed and turn it back on. I'm not sure how to
test this, though.

Mike.
-- 
Move sig.

