Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbUAVPPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUAVPPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:15:10 -0500
Received: from mail.convergence.de ([212.84.236.4]:27787 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264574AbUAVPPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:15:02 -0500
Message-ID: <400FE8F4.70500@convergence.de>
Date: Thu, 22 Jan 2004 16:15:00 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-dvb@linuxtv.org, Andrew Morton <akpm@osdl.org>, obi@linuxtv.org
Subject: Re: List 'linux-dvb' closed to public posts
References: <ecartis-01212004203954.14209.1@mail.convergence2.de> <20040121194315.GE9327@redhat.com> <Pine.LNX.4.58.0401211155300.2123@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401211155300.2123@home.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040309000907010602060307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040309000907010602060307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Linus,

Linus Torvalds wrote:
> On Wed, 21 Jan 2004, Dave Jones wrote:

>>*sigh*, anyone object to patches marking such mailing lists in
>>MAINTAINERS as 'subscription only' ?

> Sounds like they shouldn't be in MAINTAINERS at all if they can't be 
> posted to. I mean, what's the point?

Please apply the attached patch.

We've created a new e-mail address which is currently an open 
mailing-list anybody can subscribe to.

It's currently watched by the main developers. If spam takes over the 
list, we might change it to "moderated" or even route it to one single 
person.

Sorry for the inconvenience, I hope this is a solution we can all live with.

CU
Michael.

--------------040309000907010602060307
Content-Type: text/plain;
 name="dvb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb.diff"

diff -ura xx-linux-2.6.1/MAINTAINERS xx-linux-2.6.1.p/MAINTAINERS
--- xx-linux-2.6.1/MAINTAINERS	2004-01-09 09:22:32.000000000 +0100
+++ xx-linux-2.6.1.p/MAINTAINERS	2004-01-22 15:44:08.000000000 +0100
@@ -680,7 +680,8 @@
 
 DVB SUBSYSTEM AND DRIVERS
 P:	LinuxTV.org Project
-L: 	linux-dvb@linuxtv.org
+M: 	linux-dvb-maintainer@linuxtv.org
+L: 	linux-dvb@linuxtv.org (subscription required)
 W:	http://linuxtv.org/developer/dvb.xml
 S:	Supported
 

--------------040309000907010602060307--
