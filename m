Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTFKT3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 15:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTFKT3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:29:38 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:27604 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263131AbTFKT3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:29:37 -0400
Message-ID: <3EE7852C.2050605@rackable.com>
Date: Wed, 11 Jun 2003 12:38:20 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Artemio <artemio@artemio.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP question
References: <200306112043.11923.artemio@artemio.net>
In-Reply-To: <200306112043.11923.artemio@artemio.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 19:43:21.0301 (UTC) FILETIME=[B6BFC050:01C33051]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artemio wrote:

>Hello!
>
>I have the following question.
>
>My system is 2x 2.4Ghz Xeons.
>
>Linux kernel 2.4.18 compiled with SMP support sees it as four processors. 
>
  This is hyper threading.  This is intel's attempt to cram extra 
instructions on each cpu cyle.  It may make things faster, or slower.  
It really depends on what you are doing.  You can shut off hyper 
threading off in the bios.

>SMP-disabled kernel sees one, of course.
>
>I would like to know, how will it influence the system performance, if I run a 
>UP kernel?
>
  Well if you are generally only running a single program then it will 
speed things up.  If you run a number of programs all at once it will 
speed things up.  Hyperthreading tends to be a good thing if you are 
running 8 or more cpu hungry processes.

>
>What does the kernel SMP support add? Just some API for additinal 
>multiprocessor control? 
>
  For the most part.  It also enables io-apic and other stuff.


-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


