Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262874AbREVWfa>; Tue, 22 May 2001 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbREVWfU>; Tue, 22 May 2001 18:35:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:55812 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S262874AbREVWfM>; Tue, 22 May 2001 18:35:12 -0400
Message-ID: <3B0AE964.C9346FD2@evision-ventures.com>
Date: Wed, 23 May 2001 00:34:12 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105222217.AAA79157.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> Martin Dalecki writes:
> 
> > Erm... I wasn't talking about the DESIRED state of affairs!
> > I was talking about the CURRENT state of affairs. OK?
> 
> Oh, but in 1995 it was quite possible to compile the kernel
> with kdev_t a pointer type, and I have done it several times since.

Yes I remember but unfortunately some big L* did ignore
your *fine* efforts entierly in favour of developing 
/proc and /dev/random and other crap maybe?

> The kernel keeps growing, so each time it is more work than
> the previous time.
> 
> > At least you have admitted that you where the one responsible
> > for the design of this MESS.
> 
> Thank you! However, you give me too much honour.

Well ... you ask for it in the corresponding header ;-).
But it isn't yours fault indeed I admit...
I know the discussions from memmory since I'm returning REGULARLY to
this
topic in intervals of about between 6 and 24 months since about
maybe already 6 years!!! Currently they have just started to hurt
seriously. And please remember the change I have mentioned above
wasn't intended as developement but just only as an experiment...

Well let's us stop throw flames at each other.
Please have a tight look at the following *EXPERIMENT* I have
already done. It's really really only intended to mark the
places where the full mess shows it's ugly head:

http://www.dalecki.de/big-002.diff
