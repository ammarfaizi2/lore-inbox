Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284656AbRLPPdc>; Sun, 16 Dec 2001 10:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284657AbRLPPdW>; Sun, 16 Dec 2001 10:33:22 -0500
Received: from tomts19.bellnexxia.net ([209.226.175.73]:30412 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S284656AbRLPPdL>; Sun, 16 Dec 2001 10:33:11 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: Linux 2.4.17-rc1
To: linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Sun, 16 Dec 2001 10:32:36 -0500
In-Reply-To: <Pine.LNX.4.33.0112161523360.876-100000@Appserv.suse.de>
Organization: me
User-Agent: KNode/0.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20011216153236.EDB714A8A2@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Sun, 16 Dec 2001, David Relson wrote:
> 
>> IMHO, 2.4.17-rc1 seems to be ready to be promoted to 2.4.17. It's passed
>> a suitable "release candidate" test - available for a couple of days and
>> nobody has found any major problems.
> 
> Except for loop deadlock, sysvfs oops, and a glut of __devexit
> non-compiles. Whilst the sysvfs oops shouldn't affect many, loop
> is used by a lot of people, and the __devexit patches would save
> us another month of debian sid users who don't bother to read archives.

Also there are some O_DIRECT problems.  Also Chris Mason has confirmed a
opps occuring when finish_unfinished is called when remounting from ro to 
rw...

In my books this makes 2 nasties (loop, opps), 1 pita (__devexit stuff) and
2 that would nice to have working.

There are probably others.

Ed Tomlinson

Ed Tomlinson

