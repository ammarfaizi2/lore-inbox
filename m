Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284837AbSACSCy>; Thu, 3 Jan 2002 13:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSACSCp>; Thu, 3 Jan 2002 13:02:45 -0500
Received: from ns.suse.de ([213.95.15.193]:33546 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284837AbSACSC3>;
	Thu, 3 Jan 2002 13:02:29 -0500
Date: Thu, 3 Jan 2002 19:02:28 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Dual athlon XP 1800 problems
In-Reply-To: <a125gv$l3b$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201031858200.11961-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Jan 2002, H. Peter Anvin wrote:

> This seems very odd.  I thought in Athlon processors the ID string
> came from the *CPU* (via CPUID), not the BIOS...

Software overridable cpuid strings are getting quick commonplace
in CPUs from several vendors.

I beleive the reasoning is that sometimes the lead time from
manufacture to marketing is long enough that the default power-on string
may not be correct, hence the BIOS can do the XP/MP descrimination, and
set accordingly. (Unless you've got a crap BIOS).

If anyone believes they have a BIOS which doesn't do this correctly,
(/proc/cpuinfo reports XP, and x86info reports MP or vice versa),
let me know, and I'll see what I can dig up.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

