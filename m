Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSD0Kxx>; Sat, 27 Apr 2002 06:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313084AbSD0Kxw>; Sat, 27 Apr 2002 06:53:52 -0400
Received: from ns.suse.de ([213.95.15.193]:15625 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312938AbSD0Kxw>;
	Sat, 27 Apr 2002 06:53:52 -0400
Date: Sat, 27 Apr 2002 12:53:51 +0200
From: Dave Jones <davej@suse.de>
To: Bob Tanner <tanner@real-time.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIOS says MP, kernel says XP was PROBLEM: Dual (2) AMD ATHLON MP 1900+ CPUs gives APIC error on CPU[0]: 00(02)
Message-ID: <20020427125351.E14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Bob Tanner <tanner@real-time.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426213315.K25965@real-time.com> <20020426223709.A3301@real-time.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 10:37:09PM -0500, Bob Tanner wrote:
 > I just grabbed the box the CPUs came in. It states the CPUs are MP.
 > How can I tell if the problem is with the BIOS, CPUs or kernel?

ftp://ftp.suse.com/pub/people/davej/x86info/

x86info with no arguments will tell you what it thinks the CPU is
(it does MP/XP discrimination), and what the CPU reports itself as
(The processor name string)

x86info -f will tell you the CPU capability flags lines,
which should show an 'mp' bit on MP CPUs.


Note btw, grab v1.9. 1.8 had a stupid bug which broke AMD recognition.
I only just uploaded it so you may have to wait 30 mins for the
mirror script to kick in.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
