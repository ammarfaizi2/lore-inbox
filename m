Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbTBQRHZ>; Mon, 17 Feb 2003 12:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267219AbTBQRHZ>; Mon, 17 Feb 2003 12:07:25 -0500
Received: from brynhild.mtroyal.ab.ca ([142.109.10.24]:6053 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S267215AbTBQRHX>; Mon, 17 Feb 2003 12:07:23 -0500
Date: Mon, 17 Feb 2003 10:17:05 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: David Woodhouse <dwmw2@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 clings to you like flypaper
In-Reply-To: <2460000.1045500532@[10.10.2.4]>
Message-ID: <Pine.LNX.4.51.0302171014320.8008@skuld.mtroyal.ab.ca>
References: <78320000.1045465489@[10.10.2.4]> <1045482621.29000.40.camel@passion.cambridge.redhat.com>
 <2460000.1045500532@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Martin J. Bligh wrote:

> > Do you expect the kernel to read your /etc/fstab before mounting the
> > root file system, and then obey it?
> 
> No, but it remounts the disk read-write after it mounts it read-only.
> It can switch from ext2 to ext3 at that point.
>  

This is a function of your distribution.  The
init scripts *should* read /etc/fstab after the kernel mounts /
ro and then remount / rw with whatever other options are specified.

Hope that helps track down the issue.

Regards
James Bourne

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."

