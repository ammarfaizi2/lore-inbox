Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266000AbUFDVSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266000AbUFDVSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 17:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUFDVSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 17:18:30 -0400
Received: from clever.eusc.inter.net ([213.73.101.4]:32427 "EHLO
	clever.eusc.inter.net") by vger.kernel.org with ESMTP
	id S266000AbUFDVS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 17:18:28 -0400
Message-ID: <40C0E91D.9070900@scienion.de>
Date: Fri, 04 Jun 2004 23:26:53 +0200
From: Sebastian Kloska <kloska@scienion.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: APM realy sucks on 2.6.x
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm really having a hard time with APM on 2.6.x. I have a DELL Latitude
L400 with the newest BIOS release. The most important functionality
of  APM  for  me  is  the  'suspend to RAM' function which worked like
it should on all 2.4.x kernels I've tested. Under 2.6.x it simply does 
not resume the second
time. Meaning it suspends and resumes once but when suspending the second
time the machine only brings up the LEDs and FAN and is stucked. I've
modified the kernel option for APM but that did not help at all.

I've already stated that question here and googled my fingers down to the
bones. The discussion always goes in these directions:

(1) Wait until ACPI is fully functional. Although a lot of people claim that
there are a lot of BIOses around that do not implement it properly and that
even MS-evel Windows has its problems with it.

(2) Exchange the motherboard.

(3) Buy a decent computer.

(4) Stick with 2.4.x

(5) And so on and so forth

All of this is not very constructive.

My impression is that APM is slowly degenerating while ACPI is not
(yet ?) able to fill the gap. The suspend feature of ACPI is stated to
be dangerous and experimental and does not work for me at all.

After all this bashing...

Is there anyone out there who has the same experiences ?

Is there a workaround ?

Is it possible to somehow downgrade APM in the 2.6 kernel
to the 2.4.x state ?

How could one debug this kind of missbehaviour ? Where do
I have to look for potential miss configurations of the system ?

I'm really willing  to help the APM developers to track down this bug
but don't have a clue how to debug this kind stuff.

Thanks for your attention

Sebastian




