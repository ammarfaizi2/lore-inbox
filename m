Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSGUAsH>; Sat, 20 Jul 2002 20:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSGUAsH>; Sat, 20 Jul 2002 20:48:07 -0400
Received: from dsl-213-023-043-130.arcor-ip.net ([213.23.43.130]:20887 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317616AbSGUAsG>;
	Sat, 20 Jul 2002 20:48:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Mark Spencer <markster@linux-support.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Zaptel Pseudo TDM Bus
Date: Sun, 21 Jul 2002 02:52:37 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.33.0207201814170.25617-100000@hoochie.linux-support.net>
In-Reply-To: <Pine.LNX.4.33.0207201814170.25617-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17W4xi-00033v-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 July 2002 01:25, Mark Spencer wrote:
> 	The primary application we use on this interface (although
> certainly not the only one) is the Asterisk Open Source PBX
> (http://www.asterisk.org) which permits you to build a full featured PBX
> (Private Branch eXchange) or IVR (Interactive Voice Response) server with
> a Linux box.  Using the zaptel infrastructure, Asterisk provides the
> ability to deploy phone service with all your expected call features etc.

But can it give error messages in morse code?

> 	I am very interested in seeking comments both on our driver
> framework, and on how to go about submitting this for kernel inclusion if
> appropriate.

You haven't actually said a lot about the driver framework, judging from my 
quick tour of the code and website.  (Very quick, it's late here.)  Perhaps 
you could wax poetic on this subject?

In my quick tour I was looking for where the saw-off between kernel and
user space is in the source tree, and I began to get the feeling the
whole thing is kernel space, is this correct?

Anyway, this effort is exciting and ambitious.  I *want* to use this, for 
very practical reasons, never mind that it would well turn into yet another 
vibrant embedded application area for Linux.

It strikes me that much of what you're doing qualifies as hard realtime 
programming, particularly where you are doing things like interleaving file 
transmission with realtime voice.  I'm thinking that this may be a good 
chance to give the new Adeos OS-layering technology a test drive, with a view 
to achieving more reliable, lower latency signal processing and equipment 
control.  If things work out, this could qualify as the first genuine 
consumer-oriented hard realtime application for Linux.

-- 
Daniel
