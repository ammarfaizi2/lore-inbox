Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbTLIP2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266053AbTLIP2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:28:14 -0500
Received: from quechua.inka.de ([193.197.184.2]:64234 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266048AbTLIP2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:28:13 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 16:28:55 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.12.09.15.28.54.594379@dungeon.inka.de>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <3FD577E7.9040809@nishanet.com> <pan.2003.12.09.09.46.27.327988@dungeon.inka.de> <yw1x4qwai8yx.fsf@kth.se>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Dec 2003 10:29:05 +0000, Måns Rullgård wrote:

> Andreas Jellinghaus <aj@dungeon.inka.de> writes:
> 
>> maybe add this to the faq?
>>
>> Q: devfs did load drivers when someone tried to open() a non existing
>> device. will sysfs/hotplug/udev do this?
>>
>> A: there is no need to.
> 
> I never like it when the answer is "you don't want to do this".  It
> makes me think of a certain Redmond based company.

ok, rephrase:
A: all drivers are already loaded via the hotplug mechanism, and
sysfs/udev did create the device. If it is still missing, you don't
have drivers for your hardware.

better?

Andreas

