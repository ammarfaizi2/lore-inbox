Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbUKCSxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbUKCSxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 13:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUKCSxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 13:53:45 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:20705 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261801AbUKCSxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 13:53:41 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 13:53:39 -0500
User-Agent: KMail/1.7
Cc: DervishD <lkml@dervishd.net>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031147.14179.gene.heskett@verizon.net> <20041103174459.GA23015@DervishD>
In-Reply-To: <20041103174459.GA23015@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411031353.39468.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 12:53:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 12:44, DervishD wrote:
>    Hi Gene :)
>
> * Gene Heskett <gene.heskett@verizon.net> dixit:
>> >    Or write a little program that just 'wait()'s for the
>> > specified PID's. That is perfectly portable IMHO. But I must
>> > admit that the preferred way should be killing the parent.
>> > 'init' will reap the children after that.
>>
>> But what if there is no parent, since the system has already
>> disposed of it?
>
>    Then the children are reparented to 'init' and 'init' gets rid
> of them. That's the way UNIX behaves.

Unforch, I've *never* had it work that way.  Any dead process I've 
ever had while running linux has only been disposable by a reboot.

>    Raúl Núñez de Arenas Coronado

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
