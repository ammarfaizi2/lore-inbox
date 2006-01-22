Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWAVVxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWAVVxj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWAVVxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:53:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54740 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751349AbWAVVxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:53:39 -0500
Date: Sun, 22 Jan 2006 22:53:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Doug McNaught <doug@mcnaught.org>, gene.heskett@verizon.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
In-Reply-To: <1137962037.19393.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0601222250180.2221@yvahk01.tjqt.qr>
References: <20060119030251.GG19398@stusta.de>  <200601211826.02159.gene.heskett@verizon.net>
  <1137886206.11722.1.camel@mindpipe>  <200601211853.56339.gene.heskett@verizon.net>
  <87bqy5m8u3.fsf@asmodeus.mcnaught.org> <1137962037.19393.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > OTOH, if this database actually does have a better way, and its mature 
>> > and proven, then I see no reason to cripple the database people just to 
>> > remove what is viewed as a potentially dangerous path to the media 
>> > surface for the unwashed to abuse.
>> 
>> The database people have a newer and supported way to do that, via the
>> O_DIRECT flag to open().  They aren't losing any functionality.
>
>And they'll no doubt update to use it on their cycles of development.
>Which for some large vendor systems means five years.
>


"The main reason there are no raw devices [in Linux] is that I personally 
think that raw devices are a stupid idea." (Linus Torvalds, 17 Oct 1996)
http://www.ussg.iu.edu/hypermail/linux/kernel/9610.2/0030.html (wikiquote)

That stands, but a raw driver found its way in someday.

(And now luckily is on its way out again.)



Jan Engelhardt
-- 
