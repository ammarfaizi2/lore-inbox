Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbWILOY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbWILOY2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWILOY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:24:28 -0400
Received: from bcp12.neoplus.adsl.tpnet.pl ([83.27.231.12]:4508 "EHLO
	Jerry.zjeby.dyndns.org") by vger.kernel.org with ESMTP
	id S965229AbWILOY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:24:28 -0400
Date: Tue, 12 Sep 2006 16:24:19 +0200 (CEST)
From: Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: thinkpad 360Cs keyboard problem
In-Reply-To: <d120d5000609120705r26a25b44q7533c528bccb25bf@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0609121611380.2685@Jerry.zjeby.dyndns.org>
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org> 
 <Pine.LNX.4.63.0609102137240.2685@Jerry.zjeby.dyndns.org> 
 <20060910194955.GA1841@elf.ucw.cz>  <200609102054.34350.dtor@insightbb.com>
  <Pine.LNX.4.63.0609120209590.2685@Jerry.zjeby.dyndns.org>
 <d120d5000609120705r26a25b44q7533c528bccb25bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006, Dmitry Torokhov wrote:

> On 9/11/06, Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org> wrote:
>>  well, certainly 2.6.18 issue...
>
> Are you saying that it works on 2.6.17 and is broken on 2.6.18?

no, it works on 2.4.20. i didn't tried yet with other 2.6.x versions.

btw. now i compiled 2.4.33.3 using gcc 3.4.6 ,
and even though i used 486 in cpu type resulting binary requires
TSC+ from cpu :o (now recompiling with gcc-2.95.3 , and
config_notsc and it seems to boot up)

however weird behaviour aswell, because stops just after init...
no matter wheter i use init=/bin/bash or regular init.
it reports mounting root fs (ext2), then freeing unused kernel
mem (52k) and stops .

when i press keys i see output like it should be , so at least
keyboard work :)

with 2.6.18-rc5 it boots just fine, but ofcourse keyboard is
broken.

>>  kernel boots up fine, but keyboard is totally messed up,
>>  and locks up after some tries of use.
>
> Could you try describing the exact issues with the keyboard? Missing
> keypresses, wrong keys reported, etc?

with prink enabled it prints series of 'unknown scancode'
and keys are randomly messed up, and it changes, so like pressing b
results with n, then space, then nothing at all.
after some tries keyboard locks up completely.

so wrong keys reported
