Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbUBWXDL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUBWXDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:03:09 -0500
Received: from mail.convergence.de ([212.84.236.4]:52354 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262072AbUBWXCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:02:00 -0500
Message-ID: <403A865C.3080508@convergence.de>
Date: Tue, 24 Feb 2004 00:01:48 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Michael Hunold <hunold@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] tda1004x DVB frontend update
References: <10775702831806@convergence.de> <10775702843054@convergence.de> <20040223211844.A14186@infradead.org> <403A831B.7040307@convergence.de> <20040223225457.A15536@infradead.org>
In-Reply-To: <20040223225457.A15536@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

On 02/23/04 23:54, Christoph Hellwig wrote:
> On Mon, Feb 23, 2004 at 11:47:55PM +0100, Michael Hunold wrote:
> 
>>>Why would the kernel driver want to know the exact path of the firmware file?
>>
>>Because we don't use the in-kernel firmware loader at the moment.
>>
>>The driver comes from a time were 2.4 didn't have the firmware loader 
>>and drivers cloned the firmware loading stuff from one of the soundcard 
>>drivers.

> Sorry, but that's a bad excuse.  It's bogus in 2.4 too (or any given
> kernel).

I cannnot speak against this, I completely agree.

If I personally would use these type of cards, I think I would have 
converted them already.

*sigh* I think I'll step forward and have the first drivers converted to 
in-kernel i2c as soon as possible, so I can coerce the other driver 
authors to use proper firmware loading.

CU
Michael.
