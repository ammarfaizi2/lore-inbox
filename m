Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTKCKeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 05:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTKCKeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 05:34:17 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:32453 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261967AbTKCKeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 05:34:05 -0500
Message-ID: <3FA62F18.2050500@cyberone.com.au>
Date: Mon, 03 Nov 2003 21:34:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Dittmer <j.dittmer@portrix.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
References: <3FA62DD4.1020202@portrix.net>
In-Reply-To: <3FA62DD4.1020202@portrix.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan Dittmer wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi,
>
> I'm experiencing skips in games like q3demo and enemy territory on a
> dual xeon p4. That means, if I'm walking around, about every 2-3 seconds
> I'm skipping a bit of the way. It seems that the clock is running too
> slow and the games are trying to catch up every x seconds with the
> system time. 


Please ensure that X is running at priority 0. Report back if you still
have the problem.

>
> System is running 2.6.0-test9-mm1. This effect does not show with
> 2.4.23pre6aa3, though there are only two processors displayed. Is this
> normal? Judging from the temperature sensors that is not just one
> processor with its sibling but really the two physical processors. Is
> there any way with 2.4 to show all 4 processors?
> I've tried booting 2.6 with nosmp, but that results in most interrupts
> not working anymore.
> What can I try to get test9 working properly?


nosmp has been broken for quite a while. If you want to try uniprocessor,
you'd have to compile a UP kernel.

You should get as good if not better interactivity with SMP enabled, 
however.


