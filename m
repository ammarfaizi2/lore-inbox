Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267465AbSKQIVj>; Sun, 17 Nov 2002 03:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbSKQIVj>; Sun, 17 Nov 2002 03:21:39 -0500
Received: from mail1.csc.albany.edu ([169.226.1.133]:55463 "EHLO
	smtp.albany.edu") by vger.kernel.org with ESMTP id <S267465AbSKQIVi> convert rfc822-to-8bit;
	Sun, 17 Nov 2002 03:21:38 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Justin A <ja6447@albany.edu>
To: ksardem@linux01.gwdg.de
Subject: Re: bug in via-rhine network-driver (transmit timed out)
Date: Sun, 17 Nov 2002 03:30:51 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211170330.51312.ja6447@albany.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem with the integrated nic on a soyo k7vdragon+

search google/the archives for "via-rhine timeouts"

Try the linuxfet driver found here:

http://www.viaarena.com/?PageID=87#ethernet
http://downloads.viaarena.com/LinuxApplicationNotes/RedHat/May02/VIA%20RH7.2-7.1%20Fast%20Ethernet%20Controller%20Driver%20Installation%20ver%200.9.gz

I've been using it since then without problems.  I had to change malloc.h or 
whatever it used to be to slab.h a few versions ago to make it compile 
without whining, but thats all.
-- 
-Justin

