Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVBGTX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVBGTX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVBGTT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:19:58 -0500
Received: from kludge.physics.uiowa.edu ([128.255.33.129]:45572 "EHLO
	kludge.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S261262AbVBGTQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:16:48 -0500
Date: Mon, 7 Feb 2005 13:16:15 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, petero2@telia.com
Subject: Re: [ATTN: Dmitry Torokhov] About the trackpad and 2.6.11-rc[23] but not -rc1
Message-ID: <20050207191615.GC12024@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
	petero2@telia.com
References: <20050207154326.GA13539@digitasaru.net> <d120d50005020708512bb09e0@mail.gmail.com> <20050207180950.GA12024@digitasaru.net> <d120d50005020710591181fe69@mail.gmail.com> <20050207190541.GB12024@digitasaru.net> <d120d5000502071112599fa61c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000502071112599fa61c@mail.gmail.com>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Dmitry Torokhov on Monday, 07 February, 2005:
>On Mon, 7 Feb 2005 13:05:41 -0600, Joseph Pingenot
><trelane@digitasaru.net> wrote:
>> From Dmitry Torokhov on Monday, 07 February, 2005:
>> >On Mon, 7 Feb 2005 12:09:50 -0600, Joseph Pingenot
>> ><trelane@digitasaru.net> wrote:
>> >> From Dmitry Torokhov on Monday, 07 February, 2005:
>> >> >Nonetheless it would be nice to see the data stream from the touchpad
>> >> >to see why our ALPS support does not work quite right. Could you
>> >> >please try booting with "log_buf_len=131072 i8042.debug=1", and
>> >> >working the touchpad a bit. then send me the output of "dmesg -s
>> >> >131072" (or just /var/log/messages).
>> >> dmesg output, non-mouse output trimmed (for obvious reasons, if you think
>> >>  about it ;) is attached.
>> >I am sorry, I was not clear enough. I'd like to see -rc2 (the broken
>> >one), complete with bootup process, so we will see why it can't
>> >synchronize at all. (I of course don't need keyboard data of anything
>> >that has been typed after boot).
>> They're both broken in about the same way, iirc.  Is there something special
>>  in -rc2 that's not in -rc3?
>No, -rc3 will do as well. Any version starting with -rc2 should do the trick.

All info in the mail to which you repsonded were from -rc3, including 
  and especially the attachemnt.  The only info I sent from -rc1 was the
  contents of /proc/bus/input/devices in response to the *original* request.

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer
