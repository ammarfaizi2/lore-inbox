Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265872AbUGZXSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUGZXSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbUGZXSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:18:46 -0400
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:52153 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S265872AbUGZXSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:18:44 -0400
Message-ID: <4105923E.5090206@att.net>
Date: Mon, 26 Jul 2004 19:22:38 -0400
From: Peter Santoro <psantoro@att.net>
Reply-To: psantoro@att.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.26 oops (maybe solved)
References: <40FF33DE.6010307@att.net> <20040724171706.GA2530@dmt.cyclades>
In-Reply-To: <20040724171706.GA2530@dmt.cyclades>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Hi Peter, 
> 
> Care to disable ALSA to see if the problem really only happens
> when running ALSA+HIGHMEM ?
> 
> Your previous oopses in core VM code seem to be hardware problems
> to me, I haven't done any deep analysis though.
> 

Marcelo,

Thank you for responding to my post.  I know how busy you and your 
kernel colleagues are and I truly appreciate all your efforts.  The last 
thing I want to do is waste anyone's time.  (Earlier this year, I 
reported a Lexar usb thumb drive crash using an ibm pc to the usb kernel 
developers and worked with Pete Zaitcev to test his 2.4.27 patch.)

Although my asus system has been very stable for about 4 years, I do 
realize that my current problems could be due to failing hardware. 
Given that I've also experienced a few random reboots over the last 4 
months, I did replace the psu with a new Antec 430W Truepower psu.  I 
also tried replacing my cpu with an Intel P3 600e and have run all 
memtest86 tests a few times without errors.  The power to the room for 
this computer is on a separate circuit, but I suppose I could try using 
a ups.  Or maybe it's time for a new motherboard?

My original crashes started occurring around the time I upgraded to 
2.4.26 and started using HIGHMEM (no alsa) - of course, this could just 
be a coincidence.  Adding alsa simply made the system more unstable.  I 
have been running without a crash for about 5 days now (alsa without 
HIGHMEM) - until today (2 random reboots: alsa without HIGHMEM).

I am now running without HIGHMEM and without alsa, to see if it makes 
any difference.  I will probably also try running memtest86 for a day or 
two more.  If you have any other suggestions, I'd be happy to listen.


Sincerely,


Peter Santoro
