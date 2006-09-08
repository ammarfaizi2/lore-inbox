Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWIHJRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWIHJRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 05:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWIHJRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 05:17:31 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:56538 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S1750744AbWIHJRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 05:17:30 -0400
Message-ID: <45013506.1090500@draigBrady.com>
Date: Fri, 08 Sep 2006 10:16:54 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Tardieu <sam@rfc1149.net>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <44FEAD7E.6010201@draigBrady.com> <2006-09-06-13-29-46+trackit+sam@rfc1149.net> <44FEB5B6.10008@draigBrady.com> <2006-09-06-14-07-50+trackit+sam@rfc1149.net> <20060906194149.GA2386@infomag.infomag.iguana.be> <2006-09-07-11-57-00+trackit+sam@rfc1149.net> <2006-09-07-18-44-52+trackit+sam@rfc1149.net>
In-Reply-To: <2006-09-07-18-44-52+trackit+sam@rfc1149.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Tardieu wrote:
>>>>>>"Sam" == Samuel Tardieu <sam@rfc1149.net> writes:
> 
> 
> Sam> I suggest that you use the following patch instead. [...] I
> Sam> disable the watchdog until it is first used
> 
> Oops, disabling will work best if done at module initialization time :)
> Revised patch attached.

Personally I don't agree with disabling the watchdog on load.
If it is already started from the BIOS or GRUB for example,
there will be a large window of time/logic that is not protected.

Pádraig.
