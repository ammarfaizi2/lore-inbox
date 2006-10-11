Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWJKX7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWJKX7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWJKX7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:59:00 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:11487 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932164AbWJKX7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:59:00 -0400
Message-ID: <452D853B.7010000@linuxtv.org>
Date: Wed, 11 Oct 2006 19:58:51 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Greg KH <gregkh@suse.de>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] [patch 06/67] Video: cx24123: fix PLL divisor setup
References: <20061011204756.642936754@quad.kroah.org> <20061011210353.GG16627@kroah.com> <452D5EF7.80303@linuxtv.org> <20061011212959.GA18006@suse.de> <452D63D4.6050300@linuxtv.org> <20061011230125.GB26135@kroah.com>
In-Reply-To: <20061011230125.GB26135@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Oct 11, 2006 at 05:36:20PM -0400, Michael Krufky wrote:

>>>> I'll be sure to specify the subsystem, instead of only the driver name
>>>> in future patches.
>>> Yes, it's better for you to specifiy it, instead of having me guess at
>>> what it should be classified as :)
>>>
>>> I'll try to go edit the existing patches to fix this,
>> OOPS!  I just saw your -stable commit.
>>
>> Slight misunderstanding, Greg...
>>
>> Out of those six patches that I sent to you, only "cx24123: fix PLL
>> divisor setup" is a DVB patch... The remaining 5 patches are V4L patches.
>>
>> Sorry for the confusion.
> 
> Ok, can you check this latest change to make sure I got it right this
> time?  And the .17 patches were all DVB: right?

Greg,

The 2.6.18.y queue is fine now. As for the 2.6.17.y queue, it should read as follows:

DVB: cx24123: fix PLL divisor setup
V4L: Fix msp343xG handling regression

The msp343xG patch needs to be changed from DVB to V4L.

Thanks,

Michael Krufky

