Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292142AbSBOVZL>; Fri, 15 Feb 2002 16:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292145AbSBOVZC>; Fri, 15 Feb 2002 16:25:02 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:15634
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292142AbSBOVYq>; Fri, 15 Feb 2002 16:24:46 -0500
Date: Fri, 15 Feb 2002 15:58:17 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>, Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215155817.A14083@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Larry McVoy <lm@work.bitmover.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215221532.K27880@suse.de>; from davej@suse.de on Fri, Feb 15, 2002 at 10:15:32PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
>  > As a result, I had to tell Marcelo I had no choice but to drop maintaining
>  > the 2.4 help file.  The divergence, and the damage, is probably not
>  > recoverable.
> 
>  find . -name Config.help -exec cat {} >Configure.help \;

Back-seat drivers.  Answers for everything, understanding of nothing.

Sorry, it's not *nearly* that simple.  For one thing, one of the fourteen
billion requirements I've had dropped on me is that Marcelo doesn't want
any symbols in his help file that aren't actually in the 2.4 rulebase.

So I'd have to generate a custom version for him.  I used to have the
machinery to do that by parsing magic comments in my master file.  
Until Linus blew it apart.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
