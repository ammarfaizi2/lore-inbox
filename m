Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273385AbRIRLIV>; Tue, 18 Sep 2001 07:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273382AbRIRLIH>; Tue, 18 Sep 2001 07:08:07 -0400
Received: from hal.grips.com ([62.144.214.40]:23445 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S273385AbRIRLGs>;
	Tue, 18 Sep 2001 07:06:48 -0400
Message-ID: <3BA72A80.6020706@grips.com>
Date: Tue, 18 Sep 2001 13:05:36 +0200
From: jury gerold <geroldj@grips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010803
X-Accept-Language: de-at, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Feedback on preemptible kernel patch xfs
In-Reply-To: <1000581501.32705.46.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used your patch on 2.4.10-pre10-xfs from the SGI cvs tree.
2 files had to be changed
fs/xfs_support/atomic.h and fs/xfs_support/mutex.h
needed a include sched.h

rootfilesystem is ext2 everything else is xfs
athlon optimisation is switched on
chipset is via
the nvidia kernel module for OpenGL acceleration is running
hisax isdn driver for internet access
USB web cam

I have tried heavy filesystem operations (cp -ar x y && rm -rf y)
with a big compile job -j2 and some OpenGL programs together with the 
web cam

on the USB side i had some "_comp parameters have gone AWOL" messages in 
the syslog from the cpia driver
but i remember them from a no preemtion kernel as well

so far everything is stable

i like the idea but i have not made any tests on the latency yet

Regards
Gerold

Robert Love wrote:

>It now seems that all of them are indeed using ReiserFS.  There are no
>other reported problems with the preemption patch, except from those
>users...
>


