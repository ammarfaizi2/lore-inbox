Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287400AbSACTJb>; Thu, 3 Jan 2002 14:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbSACTJW>; Thu, 3 Jan 2002 14:09:22 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:5900 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S288258AbSACTJH>;
	Thu, 3 Jan 2002 14:09:07 -0500
Subject: Re: Dual athlon XP 1800 problems
From: Shaya Potter <spotter@cs.columbia.edu>
To: Dave Jones <davej@suse.de>
Cc: Andreas Bombe <bombe@informatik.tu-muenchen.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201031806360.11961-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0201031806360.11961-100000@Appserv.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 03 Jan 2002 14:07:50 -0500
Message-Id: <1010084872.23187.3.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-03 at 12:07, Dave Jones wrote:
> On Thu, 3 Jan 2002, Andreas Bombe wrote:
> 
> > The identification string is written by the BIOS.  Yours didn't know
> > about XPs so it misidentified them as MPs.  Upgrade your BIOS if this
> > bugs you.
> >
> > If ID string contradicts what you think you bought, don't trust the ID
> > string.
> 
> x86info, and 2.5.2-dj11 both have code to correctly determine XP / MP.

Just getting linux up and running on this machine, so with the original
debian kernel (2.2.20 UP) and x86info from its unstable, these retail
XPs were identified as MPs

trillian:/home/spotter# uname -a
Linux trillian 2.2.20 #1 Sun Nov 4 15:44:23 EST 2001 i686 unknown
trillian:/home/spotter# x86info 
x86info v1.7.  Dave Jones 2001
Feedback to <davej@suse.de>.

Found 1 CPU, but found 2 CPUs in MPTable.
/dev/cpu/0/cpuid: No such device
Family: 6 Model: 6 Stepping: 2 [Athlon MP]
Processor name string: AMD Athlon(tm) MP Processor 1800+

PowerNOW! Technology information
Available features:
	Temperature sensing diode present.

prehaps 2.4.17 (compiling now) will make a difference, or does one need
your kernel + x86info to do it correctly?

thanks,

shaya

-- 
spotter@{cs.columbia.edu,yucs.org}
http://yucs.org/~spotter/

