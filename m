Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130266AbQKBA1I>; Wed, 1 Nov 2000 19:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131961AbQKBA06>; Wed, 1 Nov 2000 19:26:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:40971 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130266AbQKBA0u>;
	Wed, 1 Nov 2000 19:26:50 -0500
Message-ID: <3A00B4C2.E119021F@mandrakesoft.com>
Date: Wed, 01 Nov 2000 19:26:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: npsimons@fsmlabs.com
CC: "David S. Miller" <davem@redhat.com>, garloff@suse.de, jamagallon@able.es,
        linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net> <20001101163752.B2616@fsmlabs.com> <200011012329.PAA19890@pizda.ninka.net> <20001101171158.A4708@fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Paul Simons wrote:
> 
> On Wed, Nov 01, 2000 at 03:29:15PM -0800, David S. Miller wrote:
> > Please get your facts straight.
> >
> > The rest of this thread will show you that this is not a "Red Hat
> > thing".  Connectiva, Mandrake, and others do the same thing.  In fact
> > we choose the name "kgcc" to match the convention set by these other
> > distributions.
> 
>         So other distro's did it too.  Why did nobody complain till RedHat
> did it?  Because no one else decided to use, as the default, a bleeding edge
> compiler that not only won't compile the kernel but won't even touch a lot of
> userspace code either.

Look, if you have an axe to grind about RedHat, do it somewhere else.

If you are wondering why there is one compiler to build the kernel and
one compiler to build everything else, for Mandrake at least, the reason
is stability.  We never had problems with gcc 2.95.2+fixes for userland,
but there are isolated kernel cases in 2.2.x which still give us
problems.  Therefore, our standard kernel is built with egcs 1.1.2, and
we provide that compiler to our users so they can avoid the same
problems.

	Jeff


-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
