Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263852AbRFELTU>; Tue, 5 Jun 2001 07:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263962AbRFELTL>; Tue, 5 Jun 2001 07:19:11 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:35027 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S263852AbRFELTF>; Tue, 5 Jun 2001 07:19:05 -0400
Message-ID: <3B1CC01E.4A80C2E8@TeraPort.de>
Date: Tue, 05 Jun 2001 13:18:54 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 VM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 first of all, I am not complaining, or calling things buggy. I know
that what I am running is "work in progress" and that one gets what one
deserves :-) 2.4.x has been stable for me and given me no severe problem
besides the changed pcmcia/cardbus support somewhere in 2.4.4-acx

 Just let me add my observation. The VM behaviour of 2.4.5 (started with
some 2.4.4-ac kernel) is definitely less than an improvement for *my*
setup. I am running a Thinkpad570 with 128 MB memory and about the same
amount of swap (I know, against reccomendation).

 Under the new VM behaviour, I easily get in a situation where the
system feels very sluggish. At that point in time, about 70-80% of
memory are Cache, the rest is Used and some small amount of free. Swap
is usually less than half filled and paging activity is about zero (some
sporadic page out). Typical case is a kernel build plus a Netscape
session. No unusal behaviour showing up in "top" - just sluggish system
response.

 My gut feeling is that the Cache is pressing to hard against process
memory. This may be great for some setups, but it is not good for others
(like mine).

 What would be great (maybe someone is already working on it) are some
tuning measures to tweak the cacheing behaviour.

 Just my 2 (Euro-)cents.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
