Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288266AbSAHTfc>; Tue, 8 Jan 2002 14:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288265AbSAHTfX>; Tue, 8 Jan 2002 14:35:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51719 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288260AbSAHTfJ>;
	Tue, 8 Jan 2002 14:35:09 -0500
Date: Tue, 8 Jan 2002 19:35:03 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: "Eric S. Raymond" <esr@thyrsus.com>, Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: Missing entries in Configuure.help)
Message-ID: <20020108193503.GA852@gallifrey>
In-Reply-To: <20020106210233.A30319@thyrsus.com> <20020107085307.A17914@flint.arm.linux.org.uk> <20020108124334.A24742@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020108124334.A24742@thyrsus.com>
User-Agent: Mutt/1.3.25i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.17 (i686)
X-Uptime: 19:33:07 up 32 min,  4 users,  load average: 2.06, 2.06, 1.75
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric S. Raymond (esr@thyrsus.com) wrote:

> CPU_ARM922_D_CACHE_ON
> CPU_ARM922_I_CACHE_ON
> CPU_ARM922_WRITETHROUGH

Hmm - is there anything ARM922 specific about these - i.e. is there a
reason that we shouldn't get rid of them and have some architecture
independent symbols CPU_D_CACHE_ON, CPU_I_CACHE_ON and
CPU_CACHE_WRITETHROUGH (and more to your taste) and then architectures
can use the ones which apply to them.

Doesn't seem to be a point in having dupes.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
