Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261946AbSI3HAJ>; Mon, 30 Sep 2002 03:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbSI3HAJ>; Mon, 30 Sep 2002 03:00:09 -0400
Received: from [203.117.131.12] ([203.117.131.12]:61373 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261946AbSI3HAI>; Mon, 30 Sep 2002 03:00:08 -0400
Message-ID: <3D97F7AE.5070304@metaparadigm.com>
Date: Mon, 30 Sep 2002 15:05:18 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>, Jens Axboe <axboe@suse.de>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: v2.6 vs v3.0
References: <200209290114.15994.jdickens@ameritech.net> <Pine.LNX.4.44.0209290858170.22404-100000@innerfire.net> <20020929134620.GD2153@gallifrey> <20020929154254.GD1014@suse.de> <20020929162221.GB19948@suse.de> <20020929214652.GF12928@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/02 05:46, Matthias Andree wrote:
> On Sun, 29 Sep 2002, Dave Jones wrote:
> 
> 
>>Joe Thornber sent a patch removing LVM1, but LVM2 has yet to
>>make an appearance in 2.5.x patchform afair.  LVM is in one of
>>those sneaky positions where they could theoretically cheat
>>the feature freeze, as whats in the tree right now is fubar,
>>and we need /something/ before going 2.6/3.0.
> 
> 
> Is not EVMS ready for the show? Is Linux >=2.6 going to have LVM2 and
> EVMS? Or just LVM2? I'm not aware of the current status, but I do recall
> having seen EVMS stable announcements (but not sure about 2.5 status).

 From reading the EVMS list, it was working with 2.5.36 a couple weeks
ago but needs some small bio and gendisk changes to work in 2.5.39.

http://sourceforge.net/mailarchive/forum.php?thread_id=1105826&forum_id=2003

CVS version may be up-to-date quite soon from reading the thread.
It seems to be further along in 2.5 support than LVM2 - also including
the fact that EVMS supports LVM1 metadata (which the 2.5 version of LVM2
may not do so quite so soon from mentions on the lvm list).

I haven't tried EVMS but certainly from looking at the feature set,
it looks more comprehensive and modular than LVM (with its support
for multiple metadata personalities).

I too have LVM on quite a few of my machines, including my desktop,
and if I wanted to test 2.5 right now - i'd probably have to do it
using EVMS.

~mc

