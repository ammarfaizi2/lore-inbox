Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313812AbSDPS0Q>; Tue, 16 Apr 2002 14:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313810AbSDPS0P>; Tue, 16 Apr 2002 14:26:15 -0400
Received: from ns.suse.de ([213.95.15.193]:5902 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313808AbSDPS0O>;
	Tue, 16 Apr 2002 14:26:14 -0400
Date: Tue, 16 Apr 2002 20:26:13 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ips driver compile problems
Message-ID: <20020416202613.B32185@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	"David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204161059070.1340-100000@penguin.transmeta.com> <E16xXia-0000Zb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 07:30:15PM +0100, Alan Cox wrote:
 > > Quite frankly, since after several months of being broken, nobody has
 > > stepped up to actually fix it, I am most definitely going to accept the
 > > band-aid solutions to SCSI drivers that will thus only work on x86.
 > 
 > In which case can you do it so that virt_to_bus() being exposed requires
 > the user selects
 > 
 > CONFIG_UNPORTED_CRAP_WORKAROUNDS 
 > 
 > or similar - so that we can find them, and that can't be selected on non
 > x86 ?

Funny enough, thats exactly what CONFIG_DEBUG_OBSOLETE[1] did in my tree
since virt_to_bus broke.

    Dave.

[1] Ok, the name sucks, but the intention is the same.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
