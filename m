Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291400AbSBUJ5h>; Thu, 21 Feb 2002 04:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291449AbSBUJ5a>; Thu, 21 Feb 2002 04:57:30 -0500
Received: from mcns119.docsis245.scvmaxonline.com.sg ([202.156.245.119]:23824
	"HELO server.hoeg.home") by vger.kernel.org with SMTP
	id <S291400AbSBUJ5T>; Thu, 21 Feb 2002 04:57:19 -0500
To: Jos Hulzink <josh@stack.nl>
Subject: Re: misdetection of pentium2 - very strange
Message-ID: <1014285431.3c74c477274c4@www.hoeg.home>
Date: Thu, 21 Feb 2002 17:57:11 +0800 (SGT)
From: peter@hoeg.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020221094949.A86349-100000@toad.stack.nl>
In-Reply-To: <20020221094949.A86349-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 202.42.167.98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jos Hulzink <josh@stack.nl>:

> 
> On Thu, 21 Feb 2002 peter@hoeg.com wrote:
> 
> > dmesg:
> >
> > Linux version 2.4.18-rc2 (peter@asilog-linux2) (gcc version 2.95.4
> (Debian
> > prerelease)) #3 Thu Feb 21 19:21:37 SGT 2002
> > Initializing CPU#0
> > Detected 133.225 MHz processor.
> > Calibrating delay loop... 265.42 BogoMIPS
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> It seems your CPU is actually running at 133 MHz. If I am right, the
> bogomips value should be about 2x the clock frequency on this CPU and
> kernel. Is the bogomips calculation influenced by the detected CPU speed
> ?
> Can't check now.
> 
> Can it be your system runs in a low-power mode, or that the linux
> kernel triggers a low-power mode ?

the compaq setup utility (bios setup program) reports a 333mhz with a bus speed 
of 66, so if something makes it enter a low-power mode it should be linux. but 
no apm/acpi support is compiled in/as modules.

/peter
