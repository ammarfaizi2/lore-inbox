Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWBMPhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWBMPhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWBMPhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:37:04 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:41151 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750726AbWBMPhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:37:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DmthJWPsxOlzzYuc5WTYhZfI1h+iQQBT+zaolWcHNYdVoKq8LNly/oaSopwOl6HO4K3BYFNb0l/LY4azb9f/JBo9ZcZQaWJc1HITgI5Kw/RYPoubTFOdA44e7RQPScNkMULWRuXR0hnMb9kP0zmS3NYn0kUpTnhYSBA9Yj5+37I=
Message-ID: <43F0A760.90405@gmail.com>
Date: Mon, 13 Feb 2006 10:36:00 -0500
From: Florin Malita <fmalita@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: diegocg@gmail.com, tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <20060210145238.GC18707@thunk.org> <43ECA934.nailJHD2NPUCH@burner> <20060210172428.6c857254.diegocg@gmail.com> <43F063A8.nailKUS7174MV@burner>
In-Reply-To: <43F063A8.nailKUS7174MV@burner>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:

>>Could you explain why stat->st_dev / stat->st_ino POSIX semantics forces
>>POSIX implementations to have a stable stat->st_rdev number? 
>>    
>>
>
>I was never talking about stat->st_rdev 
>  
>
This is blatantly incorrect. You *were* talking about stat->st_rdev:
http://lkml.org/lkml/2006/2/10/143

On 2/10/06, *Joerg Schilling* <schilling@fokus.fraunhofer.de> wrote:

    Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
    > The struct stat->st_rdev field need to be stable too to comply to
    POSIX?

    Correct.

    Jörg


You may claim you *never meant to* or you *never realized* you were
talking about, but you can't say you never talked about it - that's an
outright lie.

--
fm
