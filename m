Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293403AbSCSA5r>; Mon, 18 Mar 2002 19:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293407AbSCSA5i>; Mon, 18 Mar 2002 19:57:38 -0500
Received: from ns.suse.de ([213.95.15.193]:14866 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293403AbSCSA5Y>;
	Mon, 18 Mar 2002 19:57:24 -0500
Date: Tue, 19 Mar 2002 01:57:23 +0100
From: Dave Jones <davej@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
Message-ID: <20020319015722.N17410@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020318153637.J4783@host110.fsmlabs.com> <Pine.LNX.4.33.0203181446200.10517-100000@penguin.transmeta.com> <15510.32200.595707.145452@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 10:52:40AM +1100, Paul Mackerras wrote:
 > The G4 has 4 performance monitor counters that you can set up to
 > measure things like ITLB misses, DTLB misses, cycles spent doing
 > tablewalks for ITLB misses and DTLB misses, etc.
 > What I need to do now is
 > to put some better infrastructure for using those counters in place
 > and try your program using those counters instead of the timebase.

 Sounds like a good candidate for the first non-x86 port of oprofile[1].
 Write the kernel part, and all the nice userspace tools come for free.
 There are also a few other perfctr abstraction projects, which are
 linked off the oprofile pages somewhere iirc.

[1] http://oprofile.sf.net

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
