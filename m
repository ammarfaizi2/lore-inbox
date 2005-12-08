Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVLHQfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVLHQfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVLHQfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:35:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:30919 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932207AbVLHQfu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:35:50 -0500
Message-Id: <10607050.147171134059741405.JavaMail.servlet@kundenserver>
From: dirk@steuwer.de
To: <rdunlap@xenotime.net>
To: <riel@redhat.com>
To: <wli@holomorphy.com>
To: <linux-kernel@vger.kernel.org>
To: <arjan@infradead.org>
To: <diegocg@gmail.com>
Subject: AW: Re: Linux in a binary world... a doomsday scenario
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-Binford: 6100 (more power)
X-Mailer: Webmail
X-Originating-From: 5356033
X-Routing: DE
X-Message-Id: <5356033$1134059741405172.23.4.15316314492@pustefix153.kundenserver.de--1665161179>
Date: Thu, 08 Dec 2005 17:35:41 +0100
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.153
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>El Thu, 08 Dec 2005 16:49:46 +0100,
>dirk@steuwer.de escribió:
>
>> How about interconnecting it with the bugtracker?
>
>bugzilla is probably the best example of why human-managed "databases"
>are never 100% accurate and need lots of mainteinance 8) (take a look
>at mozilla's or kernel's bugzilla...). I'm tracking manually some 
>of the new devices supported in http://wiki.kernelnewbies.org/LinuxChanges
>but there're so many changes under drivers/* that god knows how many
>things I am missing. Expecting that people will maintain a wiki or a
>buzgilla or anything similar properly is like expecting that people
>will document or compile-test their patches before submitting them :P
>
>I think that the infrastructure for building such database automatically
>is already there: In the same way MODULE_DEVICE_TABLE is used by hotplug
>& friends to load the right module you can use MODULE_DEVICE_TABLE to
>build a database of the devices supported by a kernel compiled with
>"make allmodconfig", parse it and put it in a web page.


OK this would get all device ids into the database, but it would not say anything about how well the device is supported. It could be anything from the moment you add it / partial support /  pick this - excellent hardware choice random for newbie

So how about the kernel testing discussion months ago. Should there be a progam that people/developers could run, if they wanted to, that collects information from the current kernel and before sending it to kernel.org it asks the user about how happy he is with the hardware currently connected/installed to the machine.

Alternatively/Additionally you have an automated database and people keep adding things in a wikimanner to it, with some apropriate structure to it.

But still, if even bugzilla is not the perfect tool, can it be improved?

regards,
Dirk
