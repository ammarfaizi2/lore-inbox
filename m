Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSBPFMh>; Sat, 16 Feb 2002 00:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287148AbSBPFM1>; Sat, 16 Feb 2002 00:12:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25868 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287149AbSBPFMP>;
	Sat, 16 Feb 2002 00:12:15 -0500
Message-ID: <3C6DEA29.73BBAE1F@mandrakesoft.com>
Date: Sat, 16 Feb 2002 00:12:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Dave Jones <davej@suse.de>, Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com> <20020215224916.L27880@suse.de> <20020215170459.A15406@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Dave Jones <davej@suse.de>:
> >  As you obviously completely ignored my previous point, I'll reiterate it.
> >
> >  1. You run Linus' split-into-config.in script on a 2.4 tree.
> >  2. You add whatever Config.ins have been updated to the 2.4 config.ins
> >  3. You regenerate with the find example I showed in the other mail.
> >
> >  There. 2.4 Configure.help up to date with latest symbols, but
> >  containing none of the 2.5 ones.
> 
> And you've completely ignored the real problem...which is when I get
> a text change for one tree, *how do I automatically propagate it to
> the other*?  How do I *tell* that it ought to be propagated?

It's easy as hell to propagate a Config[ure].help change across trees. 
Linus even gave you the code to do it, when he split up Configure.help.

Configure.help is nothing but a database, with two different but
easy-to-parse formats in 2.4 and 2.5.


> Solutions that involve me doing an arbitrary and increasing amount of
> hand-hacking on every release are right out.

If you are hand-hacking Config[ure].help changes, you are wasting a lot
of time...

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
