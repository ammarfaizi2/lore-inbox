Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269203AbUHaVSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269203AbUHaVSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUHaVPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:15:09 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:63182 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S269228AbUHaVOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:14:32 -0400
Message-ID: <4134E959.6070807@blue-labs.org>
Date: Tue, 31 Aug 2004 17:10:49 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040825
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: george anzinger <george@mvista.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Andrew Morton <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
References: <87smcf5zx7.fsf@devron.myhome.or.jp>	 <20040816124136.27646d14.akpm@osdl.org>	 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>	 <412285A5.9080003@mvista.com>	 <1092782243.2429.254.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>	 <1092787863.2429.311.camel@cog.beaverton.ibm.com>	 <1092781172.2301.1654.camel@cube>	 <1092791363.2429.319.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>	 <20040819191537.GA24060@elektroni.ee.tut.fi>	 <20040826040436.360f05f7.akpm@osdl.org>	 <Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de>	 <Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>	 <1093916047.14662.144.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.53.0408310757430.6523@gockel.physik3.uni-rostock.de>	 <4134D11B.7050800@mvista.com> <1093985817.14662.155.camel@cog.beaverton.ibm.com>
In-Reply-To: <1093985817.14662.155.camel@cog.beaverton.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------070906010209000403090902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070906010209000403090902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>Hmmm. Well, I may be starting to lean in Tim's direction of pulling the
>clock_monotonic based uptime and going back to the jiffies based uptime.
>Atleast until we can make all the /proc/ output consistent. 
>
>I just worry that it actually fixed a problem for someone, and backing
>it out would just reopen that.
>
>Thoughts?
>
>-john
>

I would rather deal with some aesthetic breakage and get it fixed.  
Right now, having been mildly affected by differing times, and having 
seen the lengthy discussion about it, it feels like a huge octopus of 
timelines in the kernel.  Each one of them different, some just a 
little, some significantly - especially after suspend/resume events.

-david


--------------070906010209000403090902
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------070906010209000403090902--
