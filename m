Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265689AbUFRWVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUFRWVJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUFRWQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:16:39 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:60875 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265422AbUFRWPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:15:12 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Ricky Beam <jfbeam@bluetronic.net>,
       Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: SATA 3112 errors on 2.6.7
Date: Sat, 19 Jun 2004 00:18:03 +0200
User-Agent: KMail/1.5
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.33.0406181221310.25702-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0406181221310.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406190018.03500.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 of June 2004 18:28, Ricky Beam wrote:
> On Fri, 18 Jun 2004, Matthias Urlichs wrote:
> >>>Current sda: sense key Medium Error
> >>
> >>There's likely nothing wrong with your drives.  Something about that
> >>driver and the hardware aren't playing nice.
> >
> >What does the drive's SMART error log report?
>
> No errors.
>
> >I would consider swapping the power supply. Last year I had *four* 120 GB
> >drives fail on me before I changed the thing. Zero problems since.
>
> Moral: stop buying crappy power supplies. :-)
>
> My power supply is fine.  If the PS were at fault, the same thing would
> be happening all the time, not just when linux tries to throw 200 sectors
> at a time at the drives.  Windows has been stressing these drives far more
> than linux and there's been zero idication of any problems.  As I said,
> writing in O_DIRECT mode to the array @ _35MB/s_ never reports a DMA
> timeout -- I'll start increasing the buffer size to see where the cracking
> point is.

Are your drives out of Seagate, maybe?  If not, what make are they?

rjw

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
