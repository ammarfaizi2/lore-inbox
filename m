Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292320AbSBPId3>; Sat, 16 Feb 2002 03:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292322AbSBPIdU>; Sat, 16 Feb 2002 03:33:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50701 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292320AbSBPIdJ>;
	Sat, 16 Feb 2002 03:33:09 -0500
Message-ID: <3C6E1942.C08DA061@mandrakesoft.com>
Date: Sat, 16 Feb 2002 03:33:06 -0500
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
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> Dave Jones <davej@suse.de>:
> >  find . -name Config.help -exec cat {} >Configure.help \;
> 
> Back-seat drivers.  Answers for everything, understanding of nothing.

Did you read this in _How to Win Friends And Influence People_?


> Sorry, it's not *nearly* that simple.  For one thing, one of the fourteen
> billion requirements I've had dropped on me is that Marcelo doesn't want
> any symbols in his help file that aren't actually in the 2.4 rulebase.
> 
> So I'd have to generate a custom version for him.  I used to have the
> machinery to do that by parsing magic comments in my master file.
> Until Linus blew it apart.

Linus also gave you C code which, slightly modified, could discern which
CONFIG_xxx help texts were needed for a given tree.

How hard is it to maintain a database where the key for each entry is
easy an unambigious?

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
