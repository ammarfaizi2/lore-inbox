Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292734AbSBUTYV>; Thu, 21 Feb 2002 14:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292732AbSBUTYE>; Thu, 21 Feb 2002 14:24:04 -0500
Received: from smtp-2.llnl.gov ([128.115.250.82]:17135 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id <S292730AbSBUTXs>;
	Thu, 21 Feb 2002 14:23:48 -0500
Date: Thu, 21 Feb 2002 11:23:42 -0800 (PST)
From: "Tom Epperly" <tepperly@llnl.gov>
X-X-Sender: epperly@tux06.llnl.gov
To: arjan@fenrus.demon.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal
In-Reply-To: <200202211833.g1LIXZ012239@fenrus.demon.nl>
Message-ID: <Pine.LNX.4.44.0202211118030.19681-100000@tux06.llnl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002 arjan@fenrus.demon.nl wrote:

> In article <Pine.LNX.4.44.0202211010270.19681-100000@tux06.llnl.gov> you wrote:
> > 5. nVidia Corp NV15 GL (Quadro2) plugged into the AGP slot.
> 
> > By running without the X11 server, I hoped to remove the nVidia board as a 
> > source of trouble.
> 
> did you ever install the NVidia driver ?

The NVidia drivers (kernel module and X11) are installed, but I have
rebooted since disabling the X11 server. /sbin/lsmod does not list the
NVdriver in the running system.  Will the kernel load NVdriver if the X11
server is never started after a reboot?  /etc/modules.conf has this line

alias char-major-195 NVdriver

Tom

--
------------------------------------------------------------------------
Tom Epperly
Center for Applied Scientific Computing   Phone: 925-424-3159
Lawrence Livermore National Laboratory      Fax: 925-424-2477
L-661, P.O. Box 808, Livermore, CA 94551  Email: tepperly@llnl.gov
------------------------------------------------------------------------

