Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTFXQIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTFXQIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:08:13 -0400
Received: from p50804F29.dip.t-dialin.net ([80.128.79.41]:63477 "EHLO
	domino.nowhere") by vger.kernel.org with ESMTP id S262482AbTFXQIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:08:11 -0400
From: Ralf Hoelzer <ralf@well.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X. 
Date: Tue, 24 Jun 2003 18:27:55 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200306241827.55827.ralf@well.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Mas wrote:
> I don't know what this magicdev thing is, but from what you say you
> turned off I assume it's something that accesses the CD drive and
> polls its status regularly.  So your problem looks remarkably like
> mine, which I have already reported here, except I do get a panic.  My
> problem occurs when the GNOME 2 CD applet is running, and it seems to
> me the culprit is an ioctl() that tries to get the status of the
> drive.  Look for my message with "Subject: Still [OOPS] ide-scsi
> panic, now in 2.4.21 too" (just reposted it, first time only went to
> specific people).

I have a very similar problem. I just installed 2.4.21 and as soon as I
mount my CD-RW (which uses ide-scsi emulation) the system dies.
I am NOT using magicdev. Everything works fine with 2.4.20.

I will try to capture some useful debugging output.

regards,
Ralf
