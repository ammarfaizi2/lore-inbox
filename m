Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263573AbREYG0j>; Fri, 25 May 2001 02:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263575AbREYG03>; Fri, 25 May 2001 02:26:29 -0400
Received: from kwanon.research.canon.com.au ([203.12.172.254]:30215 "HELO
	kwanon.research.canon.com.au") by vger.kernel.org with SMTP
	id <S263573AbREYG0Z>; Fri, 25 May 2001 02:26:25 -0400
Subject: Re: Big-ish SCSI disks
To: scott@spiteful.org (Scott Murray)
Date: Fri, 25 May 2001 16:22:36 +1000 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105250015550.15333-100000@godzilla.spiteful.org> from "Scott Murray" at May 25, 2001 12:29:05 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010525062236.8CC1837530@zapff.research.canon.com.au>
From: gjohnson@research.canon.com.au (Greg Johnson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. Interesting that you mention the Severworks LE chipset. We
have 2 identical machines with the intel STL MOBO wich uses
the Severworks LE. They are both dual PIII 1GHz 1GB mem and ultra
160 drives. I have had nothing but trouble getting RedHat 7.1 beta-1,
7.1 beta-2 and 7.1 release. The OS tended to install ok 
but on beta1, only the up kernel would boot. On beta-2 and release
both up and smp kernels would boot. On neither of the systems
have I managed to build a kernel up or smp, new or same version
as was installed. When I tried to boot the kernel I had built,
the scsi driver would fail to load. This also happen on the Redhat
installed smp kernel in beta-1 and on any of the redhat installed
kernels in either of beta-2 or release when I tried to use disk
striping.

Have you experienced any issues like this?
Have you successfuly built a kernel that booted on these machines?

Regards

Greg.

Quoth Scott Murray:
> 
> On Fri, 25 May 2001, Greg Johnson wrote:
> 
> > Hi kernel poeple,
> >
> > Can anyone out there say for certain that 76GB SCSI disks should
> > just work with kernel versions 2.2 and/or 2.4? We need to get some
> > big disk space and have heard reports of problems with disks
> > bigger than 30GB under linux.
> 
> I set up a machine at work a few months ago with two Seagate 73GB
> Ultra160 drives (model ST173404LW) using the Adaptec AIC-7899 adapter
> on board a ServerWorks LE chipset based motherboard.  Everything has
> been working fine using the stock RedHat 7.0 2.2.16-22smp kernel.  I
> also played with some 2.4.1-ac kernels to try out ReiserFS, and also
> had no problems using the disks.
> 
> Scott
> 
> 
> -- 
> =============================================================================
> Scott Murray                                        email: scott@spiteful.org
> http://www.spiteful.org (coming soon)                 ICQ: 10602428
> -----------------------------------------------------------------------------
>      "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"
> 


-- 
+------------------------------------------------------+
| Do you want to know more? www.geocities.com/worfsom/ |
|              ..ooOO Greg Johnson OOoo..              |
| HW/SW Engineer        gjohnson@research.canon.com.au |
| Canon Information Systems Research Australia (CISRA) |
| 1 Thomas Holt Dr., North Ryde, NSW, 2113,  Australia |
|      "I FLEXed my BISON and it went YACC!" - me.     |
+------------------------------------------------------+

