Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288862AbSAFNRH>; Sun, 6 Jan 2002 08:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288867AbSAFNQ5>; Sun, 6 Jan 2002 08:16:57 -0500
Received: from ns.suse.de ([213.95.15.193]:14340 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288862AbSAFNQr>;
	Sun, 6 Jan 2002 08:16:47 -0500
Date: Sun, 6 Jan 2002 14:16:46 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.43.0201060717560.20756-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.33.0201061411150.3859-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Mr. James W. Laferriere wrote:

> > AFAIAC, the /proc/ide/ stuff should never have happened.
> > It's proven that every bit of it can be done in userspace.
> 	Then lets get rid of /proc/scsi , How about /proc/sys ...
> 	What is the differance here ?  Maybe I am missing something ?

And what would you replace /proc/scsi/ with ?

Neither of the two you mention have viable alternatives. (yet)

The only time I'd consider sysctl(2) over poking /proc/sys entries
would possibly be on an embedded system with no /proc/sys. And even then,
I'd rather try and justify having /proc. ISTR viro proposing to split
proc/sys out to sysctlfs at some point, which would solve this dilemma
nicely.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

