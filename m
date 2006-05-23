Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWEWVTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWEWVTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWEWVTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:19:06 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5610 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932281AbWEWVTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:19:05 -0400
Message-ID: <44737C33.4030503@zytor.com>
Date: Tue, 23 May 2006 14:18:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [-mm] klibc breaks my initscripts
References: <20060523083754.GA1586@elf.ucw.cz> <4473482A.3050407@zytor.com> <20060523211100.GA2788@elf.ucw.cz>
In-Reply-To: <20060523211100.GA2788@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Adjusted Cc: list]

Pavel Machek wrote:
>>
>> - a. What distro?
> 
> Hacked debian.
> 
>> - b. What's the error?
> Something about root not being mounted so it can't be remounted.

I need the details on this one.  This sounds like it could be the Debian mount getting 
confused by /proc/mounts and/or /etc/mtab.

	-hpa


