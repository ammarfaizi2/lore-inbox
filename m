Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTFXRAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTFXRAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:00:11 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:1764 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262095AbTFXRAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:00:07 -0400
Date: Tue, 24 Jun 2003 18:15:22 +0100
From: Dave Bentham <dave.bentham@ntlworld.com>
To: Ralf Hoelzer <ralf@well.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
Message-Id: <20030624181522.055b4627.dave@telekon>
In-Reply-To: <200306241827.55827.ralf@well.com>
References: <200306241827.55827.ralf@well.com>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Jun 2003 18:27:55 +0200
Ralf Hoelzer <ralf@well.com> wrote:

> Roland Mas wrote:
> > I don't know what this magicdev thing is, but from what you say you
> > turned off I assume it's something that accesses the CD drive and
> > polls its status regularly.  So your problem looks remarkably like
> > mine, which I have already reported here, except I do get a panic. 
> > My problem occurs when the GNOME 2 CD applet is running, and it
> > seems to me the culprit is an ioctl() that tries to get the status
> > of the drive.  Look for my message with "Subject: Still [OOPS]
> > ide-scsi panic, now in 2.4.21 too" (just reposted it, first time
> > only went to specific people).
> 
> I have a very similar problem. I just installed 2.4.21 and as soon as
> I mount my CD-RW (which uses ide-scsi emulation) the system dies.
> I am NOT using magicdev. Everything works fine with 2.4.20.
> 
> I will try to capture some useful debugging output.
> 
> regards,
> Ralf
> -

SNAP!

See my "2.4.21 panic on CDRW Mount" emails of a few days ago with my
panic output

Dave
