Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRBUSjm>; Wed, 21 Feb 2001 13:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbRBUSjc>; Wed, 21 Feb 2001 13:39:32 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:26320 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S129134AbRBUSjR>;
	Wed, 21 Feb 2001 13:39:17 -0500
Message-ID: <3A940B40.3020009@lycosmail.com>
Date: Wed, 21 Feb 2001 13:38:56 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac6 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: linux ac20 patch got error:
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A rather incomprehensible message, so let's flesh this out a bit.

Basically the problem occurs when patching linux/fs/reiserfs/namei.c It 
can't find it, presumably due to an error in 2.4.1, where it appears to 
me that reiserfs/ is located off of linux/ not linux/fs/. Simple to fix, 
I guess, though this would appear to mean that Linus made a mistake w/ 
2.4.1 (plz correct me if I'm wrong), though it could also be said that 
this means that Alan diff'd the wrong tree (basically a fixed tree in re 
reiserfs/)

/me needs to stop using latin while writing on lk. Maybe too much 
caffeine (just received caffeine candy sampler from ThinkGeek)

