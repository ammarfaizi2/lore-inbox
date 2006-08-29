Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965397AbWH2VLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965397AbWH2VLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965383AbWH2VLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:11:07 -0400
Received: from slackware.com ([64.57.102.34]:61908 "EHLO bob.slackware.com")
	by vger.kernel.org with ESMTP id S965397AbWH2VLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:11:06 -0400
Message-ID: <44F4AD1F.7010707@slackware.com>
Date: Tue, 29 Aug 2006 16:09:51 -0500
From: "Patrick J. Volkerding" <volkerdi@slackware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Nick Warne <nick@linicks.net>
CC: Petri Kaukasoina <kaukasoina603mxtg1n@sci.fi>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       wtarreau@hera.kernel.org, gcoady.lk@gmail.com, mtosatti@redhat.com
Subject: Re: Linux 2.4.33.2
References: <200608271235.k7RCZlru005427@harpo.it.uu.se> <7c3341450608270750t26f81d02s45e6b05572b0e255@mail.gmail.com> <20060827162828.GA28177@elektroni.phys.tut.fi> <200608271731.36674.nick@linicks.net>
In-Reply-To: <200608271731.36674.nick@linicks.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> On Sunday 27 August 2006 17:28, Petri Kaukasoina wrote:
>> On Sun, Aug 27, 2006 at 03:50:29PM +0100, Nick Warne wrote:
>>> Good question - all I can find is the slackware package
>> I guess this is what you are looking for:
>>
>> ftp://ftp.slackware.com/pub/slackware/slackware-current/source/l/glibc/glib
>> c.kernelversion.diff.gz
> 
> Good god - what a mess...

I agree, even though I'm not sure if you mean the original .h algorithm, 
my fix, or glibc's system of reducing a Linux kernel version to a single 
integer for easy comparison, though.

I'm glad my hack is getting some review.  It's of the "ugly but probably 
reliable" variety.  More so than if I'd tried to fix the loop below 
it...  I felt it much safer to just fix the input string to give it 
those "at most three parts" that it was designed for.

All the best,

Pat
