Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281755AbRKUL5n>; Wed, 21 Nov 2001 06:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281751AbRKUL5c>; Wed, 21 Nov 2001 06:57:32 -0500
Received: from news.cistron.nl ([195.64.68.38]:16647 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S281746AbRKUL5M>;
	Wed, 21 Nov 2001 06:57:12 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: New ac patch???
Date: Wed, 21 Nov 2001 11:57:11 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9tg4qn$rkk$1@ncc1701.cistron.net>
In-Reply-To: <20011121120033.C21032@duron.intern.kubla.de> <E166VIr-0004ik-00@the-village.bc.nu>
X-Trace: ncc1701.cistron.net 1006343831 28308 195.64.65.67 (21 Nov 2001 11:57:11 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E166VIr-0004ik-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> > Not exaclty. It is a 48Gig drive in a dell inspiron 8000. I think it is
>> > IBM but the logs do not show a brandname. I can try open up the case tonight
>> > if you want to know for sure?
>> 
>> It's an IBM IC25T048ATDA05-0 to be precise.
>
>Thanks. It seems IBM laptop drives are the ones that specifically need this
>fix. That ties in with the windows 98 reports/microsoft fixes.

I have Debian bugreports saying that it's not only IBM laptop drives.
It happens on Seagate, Samsung, Maxtor as well.
See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=110804&repeatmerged=yes

Note that the final fix (putting the drives in standby mode) is not
discussed in this bug report - I experimented first with turning off
the write cache in the shutdown scripts which kind of worked but
feels not quite right - you might need just enough write activity
after that to completely flush the on-disk cache.

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

