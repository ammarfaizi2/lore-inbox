Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWAYSFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWAYSFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWAYSFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:05:47 -0500
Received: from smtpout.mac.com ([17.250.248.87]:1260 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751101AbWAYSFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:05:46 -0500
In-Reply-To: <43D7B1E7.nailDFJ9MUZ5G@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C3FAC4ED-D7B6-45FE-BCC8-DDCE1E8EEC65@mac.com>
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Wed, 25 Jan 2006 13:05:46 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 25, 2006, at 12:14:15, Joerg Schilling wrote:
> Incorrect, sorry. Do you really make Linux incompatible to the rest  
> of the world?

Why should we care about compatibility with those interfaces?  Half  
our networking stack includes interfaces (like IPTables) that aren't  
compatible with _BSD_ from which parts of it were derived, let alone  
with Windows or Solaris.

>> 1 platform (Linux) _requires_ /dev/* access
> Your last line is wrong

No, it is correct.  We require /dev/* access.  The fact that we  
included /dev/sg* devices for /dev/[sh]d* was a mistake, and should  
be fixed, but those are still /dev/* access.

>> You are perfectly free to adjust your compatibility layer  
>> accordingly.
> The Linux Kernel fols unfortunately artificially hides information  
> for the /dev/hd* interface making exactly this compatibility  
> impossible.

We provide enough information for everybody else to be happy,  
including the dvd+rw-tools package.  What else do you need and why?

>> Personal attacks are offtopic, irrelevant, and rude.  Please  
>> refrain from doing so.  If you don't plan to respond to somebody's  
>> email, just don't, no reason to shout about it to a world who  
>> doesn't care.
>
> If you are against personal attacks, why didn't you intercede for  
> the postings from Jens Axboe and Albert Cahalan?

Because I didn't see them.

> I am against personal attacks and this is the first time where it  
> tooks more than a day before LKML people started with personal  
> attacks against me.

I would encourage you to ignore all personal attacks.  The people  
making them are doing so frequently because either (A) they feel they  
have been attacked and are retaliating or (B) they don't have a valid  
technical point to make.  In either case the signal-to-noise ratio is  
better if you ignore the attack and don't respond in turn, which will  
frequently cause the offending party to cease their attacks as well.

One other note:  Please do not tell Linux kernel developers that you  
know what is best for the Linux kernel.  If you have a specific bug  
or a proposed patch it will be thoroughly considered, but vague  
declarations of problems are insufficient.

Cheers,
Kyle Moffett

