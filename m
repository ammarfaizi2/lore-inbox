Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWA3Vsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWA3Vsc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWA3Vsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:48:32 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:49455 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932304AbWA3Vsb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:48:31 -0500
Message-ID: <43DE8A06.9010800@tmr.com>
Date: Mon, 30 Jan 2006 16:49:58 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
CC: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>	 <43D7A7F4.nailDE92K7TJI@burner>	 <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com>	 <43D8D396.nailE2X31OHFU@burner> <787b0d920601261619l43bb95f5k64ddd338f377e56a@mail.gmail.com>
In-Reply-To: <787b0d920601261619l43bb95f5k64ddd338f377e56a@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:

> OK, this is getting silly and downright offensive. I encourage
> everyone else to look over the code to see that I am right.
> 
> I may just be crazy enough to fork this project. I very nearly
> did about 18 months ago. I can't very well do this alone,
> because I don't have all the hardware. (It's either cdrecord
> or Asterisk -- I'm not sure which one pisses me off the most)

I can test on various 2.6 kernel ATAPI CD and DVD burners, and on 2.4 
kernel even a real SCSI CD burner as long as it lasts. I would love to 
see some mutual cooperation, but I doubt it's going to happen.

Just to be clear, Joerg is not the only one I think has been a problem 
here, he pissed off some of the developers who don't seem overly eager 
to do things which would be helpful for any burner software. From here 
it looks like a pissing content, with users well within splash range.
> 
> * was an RTOS developer
> * day job is all about secure software
> * the procps maintainer
> * running Linux 2.6.xx only
> * using FireWire, which is totally hot-plug
> 
> Perhaps the first thing to do would be to find a list of all the
> apps that depend on cdrecord. Their interface to cdrecord
> needs to be documented so that a compatibility script can
> be made.

Do you plan on changing the interface, then? Removing the SCSI stuff 
completely? Do bear in mind that there are still SCSI burners and people 
using them, and cdrecord is currently portable to many operating systems.
> 
> Matthias, can you give me a hand with this? I'll need a way
> to sort and publish incoming patches, letting them sit for a
> while. (like what Andrew Morton does for the kernel) This
> can't work like procps because the hardware varies too much.

Look a year down the road, when we have have two (or more) new 25GB 
optical formats coming out, probably with new features and commands and 
several vendors building drives for them. Both formats have DRM stuff in 
them, and GPL 3 forbids implementing DRM (simplification).

Better you than me, but it will be exciting. To the extent that I have 
the hardware I'll be glad to test.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
