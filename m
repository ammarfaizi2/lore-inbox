Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTDQSAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTDQSAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:00:37 -0400
Received: from cdrobot.com ([65.70.252.73]:50397 "EHLO mainsrv.cdrobot.com")
	by vger.kernel.org with ESMTP id S261819AbTDQSAg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:00:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Help with virus/hackers
Date: Thu, 17 Apr 2003 13:12:44 -0500
Message-ID: <78939086E7E52D4A9CDBEAB7A609781201F68C@mainsrv.cdrobot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help with virus/hackers
Thread-Index: AcMFC60WcSbZPN+qS8yzaJxTIdfRwgAAB3uQ
From: "Kenny Mann" <Kennymann@cdrobot.com>
To: "John Bradford" <john@grabjohn.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <root@chaos.analogic.com>, "joe briggs" <jbriggs@briggsmedia.com>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps this:
Using FTP to connect to another secured computer which has only that
service running.
Write-only (no read, etc) is what is used to send to it. This file will
remain open until time X.
Where X equals when that file will close and another file will begin.
Random names or perhaps based on date/time.
Everything Y amount of time, it will burn to a CD that directory or
perhaps only new files added. (all but the last file which is currently
open)
When that directory (minues the open file) size hits a certain size, it
will either ask for another CD or auto-create another CD and move
previous logs there. (or perhaps when that directory hits a certain size
it moves the old logs there and then burns them instead of every Y time)

Any suggestions/flames?

>> Linux supports console on printer. Its not totally foolproof (there
is 
>> a famous story of someone who simply reprinted the past two days of 
>> logs edited so the admins wouldnt realise when they looked)
>!!!  You can't be serious :-)
Hmm, true or not... Better safe than sorry. :-) If that person knows
about
It they are bound it try and figure something out.

Perhaps if you see a massive directory size difference (increased size)
That might be something to set it off... (assuming you follow the idea
above)

--KM

-----Original Message-----
From: John Bradford [mailto:john@grabjohn.com] 
Sent: Thursday, April 17, 2003 1:01 PM
To: Alan Cox
Cc: John Bradford; root@chaos.analogic.com; joe briggs;
'linux-kernel@vger.kernel.org'
Subject: Re: Help with virus/hackers


> > I've often wondered whether it would be worth connecting a very 
> > large serial EEPROM to a serial port interface, and have it 
> > effectively appear as a solid state printer, (to that you could 
> > cheaply log to an unmodifyable device).  Has anybody ever tried 
> > this?
> 
> Linux supports console on printer. Its not totally foolproof (there is

> a famous story of someone who simply reprinted the past two days of 
> logs edited so the admins wouldnt realise when they looked)

!!!  You can't be serious :-)

> but it works pretty well. Just use a dot-matrix printer save keeping 
> HP, Lexmark or Xerox in business 8)

Aren't you concerned with all of the trees that will be cut down to make
that paper, though?

I think 1 tree = about 50 reams.  Let's say you get through a ream a
day, that's a tree every couple of months!

Maybe there is a way to encode the data in the rings of the tree while
it's still growing, that would be the ultimate WORM device :-) :-) :-).

John.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
