Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWBQP51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWBQP51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWBQP51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:57:27 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54719 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932379AbWBQP51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:57:27 -0500
Date: Fri, 17 Feb 2006 16:56:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] make INPUT a bool
In-Reply-To: <20060214182238.GB3513@stusta.de>
Message-ID: <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr>
References: <20060214152218.GI10701@stusta.de> <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr>
 <20060214182238.GB3513@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Make INPUT a bool.
>> >
>> >INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't 
>> >make that much sense to make it modular.
>> >
>> modular would make sense to me - http://lkml.org/lkml/2006/1/25/106
>>...
>
>I don't get your point:
>You don't need INPUT modular for hotplugging devices.

Well that is, if one happens to plug in a, say, USB keyboard.


Jan Engelhardt
-- 
