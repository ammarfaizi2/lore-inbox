Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbTAHKOK>; Wed, 8 Jan 2003 05:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbTAHKOK>; Wed, 8 Jan 2003 05:14:10 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:32267 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S261836AbTAHKOJ>;
	Wed, 8 Jan 2003 05:14:09 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 2.5.54 - quota support
Date: Wed, 8 Jan 2003 10:22:49 +0000 (UTC)
Organization: Cistron
Message-ID: <avgu5p$lmt$1@ncc1701.cistron.net>
References: <20030106003801.GA522@mail.muni.cz> <20030106151908.GA640@mail.muni.cz> <20030107164028.GC6719@atrey.karlin.mff.cuni.cz> <20030108012133.GA725@mail.muni.cz>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1042021369 22237 62.216.29.67 (8 Jan 2003 10:22:49 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030108012133.GA725@mail.muni.cz>,
Lukas Hejtmanek  <xhejtman@mail.muni.cz> wrote:
>On Tue, Jan 07, 2003 at 05:40:28PM +0100, Jan Kara wrote:
>>   Reporting 'No such device' was actually bug which was introduced some
>> time ago but nobody probably noticed it... It was introduce when quota
>> code was converted from device numbers to 'bdev' structures.
>>   I also fixed one bug in quotaon() call however I'm not sure wheter it
>> could cause the freeze. Anyway patch is attached, try it and tell me
>> about the changes.
>
>Hmm, quotaon / with init=/bin/sh seems to work OK, quota accounting is made and
>repquota displays normal info.
>
>However with normal startup quotaon / still freezes :-(

ulimit ?

Mike.
-- 
They all laughed when I said I wanted to build a joke-telling machine.
Well, I showed them! Nobody's laughing *now*! -- acesteves@clix.pt

