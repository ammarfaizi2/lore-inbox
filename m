Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268824AbUJPUDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268824AbUJPUDc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUJPUBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:01:38 -0400
Received: from relay.pair.com ([209.68.1.20]:42760 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268824AbUJPUBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:01:02 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <417170BE.9030906@kegel.com>
Date: Sat, 16 Oct 2004 12:04:30 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared
 doesn't work well
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org> <20041016200627.A20488@flint.arm.linux.org.uk> <20041016212440.GA8765@mars.ravnborg.org> <20041016204001.B20488@flint.arm.linux.org.uk>
In-Reply-To: <20041016204001.B20488@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>>Btw. this is not about "case-challenged" filesystems in general. This is
>>about making the kernel usefull out-of-the-box for the increasing
>>embedded market.
>>Less work-around patces needed the better. And these people are often
>>bound to Windoze boxes - for different reasons. And the individual
>>developer may not be able to change this.

Hear, hear!

> You still need a case-sensitive filesystem to be able to create a root
> filesystem for their embedded device. 

A case-preserving filesystem should be enough.  Or do you have a counterexample?

In any case, when I was building embedded filesystems,
I used an ext2 image file with genext2fs regardless of which operating
system I was running; made it a heck of a lot easier to
do things like create device files.
- Dan


-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
