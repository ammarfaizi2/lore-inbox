Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUAaHi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 02:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUAaHi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 02:38:57 -0500
Received: from hb6.lcom.net ([216.51.236.182]:6796 "EHLO
	petrus.dynamic.digitasaru.net") by vger.kernel.org with ESMTP
	id S264147AbUAaHiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 02:38:54 -0500
Date: Sat, 31 Jan 2004 01:38:51 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Luke-Jr <luke7jr@yahoo.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
Message-ID: <20040131073848.GE7245@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Nigel Cunningham <ncunningham@clear.net.nz>,
	Luke-Jr <luke7jr@yahoo.com>,
	swsusp-devel <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1075436665.2086.3.camel@laptop-linux> <200401310622.17530.luke7jr@yahoo.com> <1075531042.18161.35.camel@laptop-linux> <20040131064757.GB7245@digitasaru.net> <1075532166.17727.41.camel@laptop-linux> <20040131071619.GD7245@digitasaru.net> <1075534088.18161.61.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075534088.18161.61.camel@laptop-linux>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Nigel Cunningham on Saturday, 31 January, 2004:
>Hi again.
>On Sat, 2004-01-31 at 20:16, Joseph Pingenot wrote:
>> >In the past I have only done patches against the 2.6.x kernels. I'm
>> >thinking, however, of requesting space on kernel.org for patches against
>> >-rcX and -mm kernels. You're the second person to ask. If I get asked
>> That'd rock.  It's a very important thing nowadays.
>Okay. I'll ask then.
>> >some more, I might do it :> (It's not that it's hard, just that it takes
>> Hmm.  Do I have to be a *new* person to ask, or can I just keep
>>   asking until you give in?  ;)
>:> Okay, okay, I give in! (That wasn't hard, was it?!)

Yay!  Yet again does annoyance reign victorious!

>> >time and today is my last day working on the code full time).
>> 
>> Oi!  I'll give you five (US) dollars.  Is that near enough?  :)
>:>
>> Actually, in all seriousness, is there some sort of tips place
>>   to give you money to fund the project?  Although I don't have
>>   much time (working on yet another cpu governor, amongst other
>>   things), I can not eat at a restauraunt for lunch a couple of
>>   times and send the money your way.  :)
>Sourceforge have a donations thing now, but I haven't done my bit to
>sign the project up for it. Frankly, after all the support LinuxFund
>gave over the last four months, I'd rather encourage people to give to
>them :>

Kewl beans.  I'll see what I can do then.

>> >> Also, how does this differ from what is currently in the vanilla
>> >>   kernels?
>> >The best way to answer that is to point to
>> >http://swsusp.sourceforge.net/features.html.
>> Ah.  Thankye.
>> A few last questions while I'm at it.  (I'm struggling to get it to work
>>   with my new Dell Inspiron 8600.)  Is it alright to have the different
>>   swsus/pmdisk versions enabled in the same kernel?  Finally, is there
>Yes, I worked hard on making it play nicely with them. It does replace
>the refrigerator they used, but if I've done it right and it hasn't been
>broken it since (by any of the three of us), they shouldn't care.

Cool.  I think I'll disable the others just in case [you only need
  *one* suspending mechanism].

>>   any specific way to create the swap space for saving the state to?
>Suspend2 will use any swap space you have available. It will even
>automatically turn on a swap partition or file for you at the start of
>suspending, and turn it off at the end. It doesn't care about how the
>swap space is distributed or whether it's a partition or a file or a
>combination. Saving to local IDE and SCSI is tested, but I've had
>limited success with SCSI due to the lack of power management on the
>drives I was testing with (the machine resumed up to the point where it
>wanted to use the SCSI drive again with the restored kernel, at which
>point the driver paniced because the request numbers were out of sync).

Hmmm.  Would turning on the swap space be a better option then?  I had
  left it off so that it wouldn't get used.
Something I was wondering about: what happens then if the swap space
  is all filled?  I liked having a dedicated partition so that that
  wouldn't be an issue.
BTW, the drive in this is a plain IDE one.

>>   ran mkswap on it.  However, after I tried to suspend, it didn't
>>   recognize the saved data.

>2.6 has problems with flushing caches properly at the moment. It might
>be related to that. I'd need more info to properly diagnose the problem.

Hmm.  I'm hoping to take advantage of 2.6.2-rc3's ACPI updates
  (I have some acpi wonkiness which is undoubtedly related to
  Dell and its infamous DSDTs).  Any chance you could make that
  your first -rc target?  :)  I'll give you a lollipop whenever
  I see you IRL.

Anyhow, I'm gonna hit the hay.  Thanks for the great work; you're
  truly an asset to Kiwi-dom.  ;)
