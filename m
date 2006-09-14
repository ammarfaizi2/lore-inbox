Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWINKrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWINKrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWINKrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:47:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:39822 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751143AbWINKrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:47:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uM7fTIMzwnwdVs0a6DIvS74ll9/O0AchM3JOPsvsG0t0LgILwSGpdORi7mzzghj1ysdFkpMX57PUlqNVk295xOaBqw+WJ5aTPYvJoVda1LBZN9Wn0U9KQbx3qZ+omwF21Rt8sbRuk9VlFvV1KeSZtw9q+Jrzs1IwclO7JpXcQkc=
Message-ID: <4509332C.40706@gmail.com>
Date: Thu, 14 Sep 2006 14:47:08 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Matthew Locke <matthew.a.locke@comcast.net>, linux-pm@lists.osdl.org,
       Preece Scott-PREECE <scott.preece@motorola.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] community PM requirements/issues and PowerOP [Was:
 Re: So, what's the status on the recent patches here?]
References: <20060913045405.BA7DD1A0084@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <ADE4D9DBCFC3A345AAA95C195F62B6DD01B6A3D9@de01exm64.ds.mot.com> <20060914091211.GA14874@elf.ucw.cz> <a1a8b0b5c71a78fafd450c10ec52a60d@comcast.net> <45092968.7070508@gmail.com> <20060914101704.GA17820@elf.ucw.cz>
In-Reply-To: <20060914101704.GA17820@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> operating points it is possible to implement the "cpufreq frequency 
>> selection logic" in user space and having such functionality in the kernel 
>> just violates the main rule of having everything possible outside of the 
>> kernel.
> 
> You got the rules wrong. "Keep the code out of kernel" is important
> rule, but probably not the main one.
funny. not to mention that it was not the only argument I presented but please 
tell us explicitly what's your reason to blow out kernel footprint by the code 
which can be handled outside the kernel. I'd prefer to see technical reasons a 
kind of latencies, etc but not  the constant refrain "don't touch cpufreq 
interface". Especially considering that proposed improvements _do_ _not_ 
_change_ the interface.

And just FYI kernel footprint was stated as one of main current issues at least 
on the last OLS.
> 
>> Paval, plz NOTE, that  you don't have lkml in CC on this thread and I 
>> personally feel that you've brought a really terrible confusion to everyone 
>> with your lkml step. I'm wondering whether you are braking "no cross 
>> postings" rule as well.....
> 
> Cc-ing lkml is considered okay.
> 
> Anyway, please do _proper_ submission, 
I already did _proper_ submissions several time on IMO the _proper_ list.
>cc-ing lkml, explaining why it
> is needed so that me and lkml actually know what is going on. 
will do

Eugeny
>Include
> those "elevator pitches".
> 									Pavel
> 

