Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288998AbSAFSVL>; Sun, 6 Jan 2002 13:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288999AbSAFSVB>; Sun, 6 Jan 2002 13:21:01 -0500
Received: from ns.suse.de ([213.95.15.193]:19977 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288998AbSAFSUm>;
	Sun, 6 Jan 2002 13:20:42 -0500
Date: Sun, 6 Jan 2002 19:20:41 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.43.0201061022420.21126-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.33.0201061918090.3859-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Mr. James W. Laferriere wrote:

> 	And what is there to replace /proc/ide ?  I see no other facility
> 	in /proc to do the job .  Again am I missing something here ?

99% of everything done by /proc/ide/ can be done in userspace by parsing
/proc/bus/pci. The remaining 1% can be done with ioctls.

The info exposed by /proc/scsi may be exposed by ioctls also, (in which
case, that too can be done entirely in userspace), however, I'm not sure
everything shown there is accessable by means other than proc parsing.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

