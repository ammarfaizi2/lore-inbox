Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVCGQKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVCGQKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 11:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVCGQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 11:10:41 -0500
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:60608 "EHLO
	av8-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261221AbVCGQKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 11:10:35 -0500
Message-ID: <422C7CF3.9080609@fulhack.info>
Date: Mon, 07 Mar 2005 17:10:27 +0100
From: Henrik Persson <root@fulhack.info>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: dtor@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: Touchpad "tapping" changes in 2.6.11?
References: <422C539A.4040407@fulhack.info> <d120d500050307055522415fb3@mail.gmail.com>
In-Reply-To: <d120d500050307055522415fb3@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Mon, 07 Mar 2005 14:14:02 +0100, Henrik Persson <root@fulhack.info> wrote:
> 
>>Hi there.
>>
>>I noticed that the ALPS driver was added to 2.6.11, a thing that alot of
>>people probably like, but since my touchpad (Acer Aspire 1300XV) worked
>>perfectly before (like, 2.6.10) and now the ALPS driver disables
>>'hardware tapping', wich makes it hard to tap. I commented out the
>>disable-tapping bits in alps.c and now it's working like a charm again.
>>
> 
> 
> Hi,
> 
> Could you please try 2.6.11-mm1. It has bunch of Peter Osterlund's
> patches that shoudl improve the situation with tapping.

Well, -mm1 didn't quite agree with my savage gfx drivers. But I'm 
booting with psmouse.proto=exps now, and it's working the way I'm used 
to now.

The Aspire 1300-series is quite different from the 1350 ones.. The 
touchpad on the 1300 will work like a charm without the synaptics driver 
(but no fancy stuff is supported, I guess). Before you could boot and be 
happy without the synaptics driver, now you probably have to install the 
synaptics driver to be happy.. Maybe that's not so good. :)

Could this touchpad use the "exps" proto as default and then you could 
reconfigure if you want to use the ALPS driver..?

-- 
Henrik Persson
