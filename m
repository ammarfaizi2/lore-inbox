Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131098AbRCGOZN>; Wed, 7 Mar 2001 09:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131092AbRCGOZD>; Wed, 7 Mar 2001 09:25:03 -0500
Received: from ns.suse.de ([213.95.15.193]:2317 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131098AbRCGOYz>;
	Wed, 7 Mar 2001 09:24:55 -0500
Mail-Copies-To: never
To: Neale.Ferguson@softwareAG-usa.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-s390x progress
In-Reply-To: <20010307141337Z131097-407+2208@vger.kernel.org>
From: Andreas Jaeger <aj@suse.de>
Date: 07 Mar 2001 15:24:14 +0100
In-Reply-To: <20010307141337Z131097-407+2208@vger.kernel.org> (Neale.Ferguson@softwareAG-usa.com's message of "Wed, 7 Mar 2001 09:04:31 +0200")
Message-ID: <hobsrd3be9.fsf@gee.suse.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neale.Ferguson@softwareAG-usa.com writes:

> I've been using the "Linux from Scratch" (LFS) document as a guide for building
> a basic Linux system. The only things I've done outside the instructions
> include:
> 
> 1. Built 32 bit version of binutils, gcc, glibc for s390x
> 2. Built kernel
> 3. Created /root64 and populated it with /usr /bin etc.
> 4. Built 64-bit libncurses
> 
> I've now built statically linked 64-bit versions of:
> 1. bash
> 2. bzip2
> 3. diffutils
> 4. fileutils
> 
> These are all installed in the /root64 tree.
> 
> According to the LFS instructions I should now build grep, gzip, make,
> sed, shellutils, tar, and textutils, before going onto the next phase.
> However, I cannot find grep, sed, or tar srpms on the SuSE CDs.

this is getting off-topic but from SuSE 7.1:

$ rpm -q -f `which grep`
base-2001.1.15-0

You'll find in the base rpm also the sources of sed and tar.

Hope this helps - and have fun with Linux on your small;-) machine,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
