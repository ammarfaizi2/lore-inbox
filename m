Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130879AbQKBAaS>; Wed, 1 Nov 2000 19:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131465AbQKBAaI>; Wed, 1 Nov 2000 19:30:08 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:63220
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S130879AbQKBAaB>; Wed, 1 Nov 2000 19:30:01 -0500
Date: Wed, 1 Nov 2000 17:22:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Nathan Paul Simons <npsimons@fsmlabs.com>
Cc: "David S. Miller" <davem@redhat.com>, garloff@suse.de, jamagallon@able.es,
        linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001101172252.E32641@opus.bloom.county>
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net> <20001101163752.B2616@fsmlabs.com> <200011012329.PAA19890@pizda.ninka.net> <20001101171158.A4708@fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001101171158.A4708@fsmlabs.com>; from npsimons@fsmlabs.com on Wed, Nov 01, 2000 at 05:11:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 05:11:58PM -0700, Nathan Paul Simons wrote:
> On Wed, Nov 01, 2000 at 03:29:15PM -0800, David S. Miller wrote:
> > Please get your facts straight.
> > 
> > The rest of this thread will show you that this is not a "Red Hat
> > thing".  Connectiva, Mandrake, and others do the same thing.  In fact
> > we choose the name "kgcc" to match the convention set by these other
> > distributions.
> 
> 	So other distro's did it too.  Why did nobody complain till RedHat
> did it?  Because no one else decided to use, as the default, a bleeding edge 
> compiler that not only won't compile the kernel but won't even touch a lot of 
> userspace code either.

That's not quite true.  gcc 2.96/7 isn't bad.  It's just not intended for use
on production systems.  But, it has a lot of things that people will have to
get used to for gcc 3.0.  It also has a more robust/not-as-sucky C++ abi.
RedHat decided haveing a g++ that sucks less and including more compat
libraries in 7.1/whatever was worth it.  I don't think so, but I'm not RedHat
:)

The idea of kgcc isn't a new one.  It's been around, unoffically, since Linus
said "Ok, I'd recommend people use X compiler".  It's now a more formal idea
and most x86 distributions have one now.
/me is glad he has more PPC boxes then x86 ones.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
