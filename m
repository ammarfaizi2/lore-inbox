Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751941AbWG0Sb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbWG0Sb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbWG0Sb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:31:58 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:16260 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751939AbWG0Sb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:31:58 -0400
Date: Thu, 27 Jul 2006 11:30:54 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jan Kasprzak <kas@fi.muni.cz>
cc: dean gaudet <dean@arctic.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 3ware disk latency?
In-Reply-To: <20060727121137.GM1703@fi.muni.cz>
Message-ID: <Pine.LNX.4.63.0607271129380.11253@qynat.qvtvafvgr.pbz>
References: <20060710141315.GA5753@fi.muni.cz> 
 <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org> 
 <1153946249.13509.29.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0607261440470.4568@twinlark.arctic.org> <20060727121137.GM1703@fi.muni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Jan Kasprzak wrote:

> dean gaudet wrote:
> : my suspicion is the 3ware lacks any sort of "fairness" in its sharing of
> : buffer space between multiple units on the same controller.  and by
> : disabling the write caching it limits the amount of controller memory that
> : the busy disk can consume.
>
> 	Hmm, do you have a battery backup unit for 9550sx? I don't,
> and the 3ware BIOS does not even allow me to enable write caching without it.
> So I don't think the write caching on the controller side is related
> to my problem.

interesting, on the 9500 series cards I have it pops up a 'are you really sure, 
this is dangerous' warning, but it did allow me to turn on write caching (I've 
since received the batteries, but I did test it before that)

David Lang

> 	I have been able to improve the latency by upgrading the firmware
> to the newest release (wow, they even have a firmware updating utility
> for Linux!).
>
> -Yenya
>
>
