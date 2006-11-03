Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753210AbWKCOVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbWKCOVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 09:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbWKCOVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 09:21:24 -0500
Received: from smtp18.dc2.safesecureweb.com ([65.36.255.252]:5843 "EHLO
	smtp18.dc2.safesecureweb.com") by vger.kernel.org with ESMTP
	id S1753210AbWKCOVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 09:21:23 -0500
Message-ID: <001b01c6ff53$41a21eb0$0732700a@djlaptop>
From: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
To: "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>
Cc: "Bill Davidsen" <davidsen@tmr.com>, "Jean Delvare" <khali@linux-fr.org>,
       <davidz@redhat.com>, "Richard Hughes" <hughsient@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Dan Williams" <dcbw@redhat.com>, <linux-kernel@vger.kernel.org>,
       <devel@laptop.org>, <sfr@canb.auug.org.au>, <len.brown@intel.com>,
       <greg@kroah.com>, <benh@kernel.crashing.org>,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>,
       "Pavel Machek" <pavel@suse.cz>
References: <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com> <znLIYxER.1162453921.3011900.khali@localhost> <454A306C.3050200@tmr.com> <000b01c6feb4$c340a580$0732700a@djlaptop> <20061103132340.GB4257@khazad-dum.debian.net>
Subject: Re: [PATCH v2] Re: Battery class driver.
Date: Fri, 3 Nov 2006 09:20:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>
To: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
Cc: "Bill Davidsen" <davidsen@tmr.com>; "Jean Delvare" <khali@linux-fr.org>; 
<davidz@redhat.com>; "Richard Hughes" <hughsient@gmail.com>; "David 
Woodhouse" <dwmw2@infradead.org>; "Dan Williams" <dcbw@redhat.com>; 
<linux-kernel@vger.kernel.org>; <devel@laptop.org>; <sfr@canb.auug.org.au>; 
<len.brown@intel.com>; <greg@kroah.com>; <benh@kernel.crashing.org>; 
"linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>; "Pavel 
Machek" <pavel@suse.cz>
Sent: Friday, November 03, 2006 8:23 AM
Subject: Re: [PATCH v2] Re: Battery class driver.


> On Thu, 02 Nov 2006, Richard B. Johnson wrote:
>> No known laptop bothers to do this. That's why the batteries fail at the
>> most inoportune times and why it will decide to shut down when it feels
>> like it, based totally upon some detected voltage drop when a disk-drive
>> started.
>
> Weird, I though the whole point behind a SBS hardware stack requiring
> something fairly intelligent in the battery pack and allowing for (runtime
> switchable!) Ah or Wh modes of operation was to allow vendors to do 
> exactly
> that: measure (V,A) permanently while the cells are above the safety 
> cut-off
> fuse level, and accumulate it...
>
> Well, IBM embedded a microcontroller of some sort on every SBS ThinkPad
> battery pack, and the ThinkPad reports battery data in Wh, so I expected 
> it
> to actually do the hard work to know how much energy is still left in the
> pack...  especially given how much $$$ they want for the packs :-) I have 
> no
> idea of what software is really running inside the battery pack, of 
> course,
> so maybe the SBS battery EC just sits there doing something else instead 
> of
> taking real-time measurements of the battery charge (that wouldn't 
> surprise
> me too much...).

I'm not sure anybody actually embeds a micro. There is some chip, originally 
make by National, that
was supposed to monitor the battery state. I know that I have used five 
laptops so far and have
never been able to obtain any intellegent operation. They just shut down 
when they feel like it.
They do go to "suspend" mode to save power as well, always at the most 
inopertune moment.

Maybe the "ThinkPad" actually has some intellegence within. The cost of the 
batteries only reflects
the cost of defending lawsuits <grin> and not the cost of its components. 
Batteries made in
China seem to become "excited" at inopertune times.

>
> -- 
>  "One disk to rule them all, One disk to find them. One disk to bring
>  them all and in the darkness grind them. In the Land of Redmond
>  where the shadows lie." -- The Silicon Valley Tarot
>  Henrique Holschuh


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 (somewhere). IT removed email "privileges" 
for engineers!
New Book: http://www.AbominableFirebug.com


