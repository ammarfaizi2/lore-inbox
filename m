Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270580AbRHIUMa>; Thu, 9 Aug 2001 16:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270578AbRHIUMU>; Thu, 9 Aug 2001 16:12:20 -0400
Received: from mail2.citistreetonline.com ([209.191.12.26]:9353 "EHLO
	rstc12ce1.rsd.citistreet.org") by vger.kernel.org with ESMTP
	id <S270579AbRHIUMI>; Thu, 9 Aug 2001 16:12:08 -0400
Subject: 2.4.7-ac3 and above
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.07a  May 14, 2001
Message-ID: <OF30645D34.4F93389F-ON85256AA3.006ECC48@rsd.citistreet.org>
From: jbearce@citistreetonline.com
Date: Thu, 9 Aug 2001 16:10:53 -0400
X-MIMETrack: Serialize by Router on NotesExt01/RSD/CitiStreet(Release 5.0.8 |June 18, 2001) at
 08/09/2001 04:12:11 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing random lockups with 2.4.7-ac3 and up and can't seem
to pin it down to anything.  The problem doesn't seem to be load related,
although it might be disk-related. I can't accurately reproduce the problem
but it seems to be about once a day with -ac8 through -ac10, -ac4 through
-ac7 were much more frequent.

I'm running on a Dell Precision 420 Workstation dual 933Mhz, 2 IDE HD with
and without DMA enabled.  The only thing I've recently change in my kernel
configs, is the use of raid0 to tie the 2 drives together.  I don't see any
abnormal messages in any logs.  I've got a few test machines at my desk
that are the same hardware, but with SCSI drives and no raid0 and I'm
seeing the same problem about once a day.

I'm running XFree 4.1 with DRI enabled, but haven't had a chance to try to
reproduce the problem in a console environment.  I completely lose
connectivity to my machine (both locally and over the network). I'm
stumped.  The one Compaq server I'm running -ac10 on at the moment is
running fine, with no X, but there's no load on the machine.  It's also a
933 Dual Processor machine.

I'm basically running the latest and greatest Debian (Sid) packages.  I
don't expect anyone to have an answer for me, but what kind of information
can I provide that may be useful.




