Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135594AbRDSNZ6>; Thu, 19 Apr 2001 09:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135668AbRDSNZt>; Thu, 19 Apr 2001 09:25:49 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24760 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135666AbRDSNYV>;
	Thu, 19 Apr 2001 09:24:21 -0400
Message-ID: <3ADEE701.F3726B5B@mandrakesoft.com>
Date: Thu, 19 Apr 2001 09:24:17 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-pm-devel@lists.sourceforge.net
Subject: Re: PCI power management
In-Reply-To: <3ADEA108.50BB415D@mandrakesoft.com> <20010419101852.7992@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>  - On SMP, we need some way to stop other CPUs in the scheduler
> while running the last round of sleep (putting devices to sleep) at least
> until all IO layers in Linux can properly handle blocking of IO queues
> while the device sleeps.

I think either Rusty or Anton wrote code to enable and disable CPUs...

CPU hotplugging but it would be useful for PM too.

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
