Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUCALoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbUCALoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:44:15 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:39601 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261219AbUCALoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:44:08 -0500
Date: Mon, 01 Mar 2004 19:43:49 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Cc: "Micha Feigin" <michf@post.tau.ac.il>,
       "Software suspend" <swsusp-devel@lists.sourceforge.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <1ulUA-33w-3@gated-at.bofh.it>  <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz>  <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th>  <20040229213302.GA23719@luna.mooo.com>  <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr36ljbsu4evsfm@smtp.pacific.net.th>
In-Reply-To: <1078139361.21578.65.camel@gaston>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2004 22:09:22 +1100, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>
>>
>> - that 2.4 style PM got depreciated and let die before the
>>    "new-driver-model" PM is workin
>
> Except that it never worked

It is actively used for ide, network, serial drivers with swsusp2.

>
>> - that perfectly good drivers were rewritten from scratch,
>>    but without functioning PM support
>
> Please, give names.
>

A few I tested:

AGP (sis, savage)
trident (Ali153x)
Serial (82x50)
Yenta (Toshiba Topic95)

Regards
Michael
