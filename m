Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUJWEHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUJWEHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUJVReh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:34:37 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:27271 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S266316AbUJVRNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:13:32 -0400
Date: Fri, 22 Oct 2004 19:13:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac2
In-Reply-To: <1098391389.3792.1.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.53.0410221910010.13575@yvahk01.tjqt.qr>
References: <1098379853.17095.160.camel@localhost.localdomain> 
 <Pine.LNX.4.53.0410212046250.9699@yvahk01.tjqt.qr> <1098391389.3792.1.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >2.6.9-ac2
>> >o	Flash lights on panic as in 2.4			(Andi Kleen)
>>
>> It would be cool to have the pc speaker doing a toneladder when the Kernel

s/toneladder/pcspkr beep scale/;

>> oopses. That is (was) especially helpful when in X when the lights did not
>> flash. Might as well add to the accessibility of the kernel.
>
>Sometimes it's possible to continue normally after an Oops.  For months,

And sometimes, it just locks up and you wait forever, thinking that X might
just block again because someone's hogging.

>even years.  This could get annoying in a data center real quick.

Well this of course should stay as a compile-time (better yet: sysctl) option
that is set to 'n' by default. Home users who wish to use it may enable it.

http://linux01.org:2222/f/hxtools/kernel/24-oops_snd.diff
I once wrote this, but did not port it to 2.6 since accessing the speaker
changed.



Jan Engelhardt
-- 
