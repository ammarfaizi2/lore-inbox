Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSE0U30>; Mon, 27 May 2002 16:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316758AbSE0U3Z>; Mon, 27 May 2002 16:29:25 -0400
Received: from inje.iskon.hr ([213.191.128.16]:58247 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S316755AbSE0U3Y>;
	Mon, 27 May 2002 16:29:24 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.5.18 / ext3 / oracle trouble
In-Reply-To: <877klr2ank.fsf@atlas.iskon.hr> <d6vi836v.fsf@sap.com>
	<3CF1E5CF.2B11258F@zip.com.au> <dnvg9am14i.fsf@magla.zg.iskon.hr>
	<871ybx4awp.fsf@atlas.iskon.hr> <3CF29708.C3AF53E1@zip.com.au>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Mon, 27 May 2002 22:29:11 +0200
Message-ID: <dnlma5nxm0.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

>> 
>> And during one of the tests on ext3, when machine actually survived,
>> just after exiting X I had a welcome message waiting, saying something
>> like this:
>> 
>>  Assertion failure: journal_dirty_metadata() at transaction.c:1146
>>  "jh->b_frozen_data == 0"
>
> I've seen them under load with data=journal.  Were you using data=journal
> at the time?
>

Yes.

Don't know if it's strictly needed as Oracle tries to keep consistency
on it's own, but it can't hurt, I think (except performance wise, but
sometimes it can be a win, too).
-- 
Zlatko
