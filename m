Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264111AbTE0VDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbTE0VDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:03:52 -0400
Received: from host197-159.pool62211.interbusiness.it ([62.211.159.197]:46353
	"EHLO stracco.binary-only.priv") by vger.kernel.org with ESMTP
	id S264111AbTE0VDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:03:50 -0400
Message-ID: <3ED3D582.4080303@namesys.com>
Date: Wed, 28 May 2003 01:15:46 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
References: <Pine.LNX.4.44.0305271048380.6665-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305271048380.6665-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>This is not just a core kernel issue - we've seen this with subsystems 
>like ext3 and ReiserFS: they were "finished' and "stable", but what made 
>them _really_ stable was a release or two on vendor kernels, and thousands 
>of users.
>
>  
>
I wish this wasn't true, but it was.  When I say something is stable, I 
mean that we have fixed every reported bug.

I have this hypothesis of software engineering which is that every order 
of magnitude increase in the number of users finds as many bugs as the 
previous order of magnitude increase.

With ReiserFS, I several times publicly said that it was stable, and for 
that order of magnitude of users it was, and then the order of magnitude 
changed and it wasn't....

With V4 we are going to benefit from an accumulation of testing scripts 
(and more experience at what we do plus less hurried code), and that 
will put us a few orders of magnitude farther ahead.

It will be a bit ironic that V4 is architected for greater data security 
with its atomic filesystem operations, and yet V3 will for quite some 
time offer greater data security in reality.

(V4 is currently being tuned for CPU consumption, and its VM 
interaction.  We have some fond hope of releasing in July.)

-- 
Hans


