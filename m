Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTBKB3s>; Mon, 10 Feb 2003 20:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbTBKB3s>; Mon, 10 Feb 2003 20:29:48 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:8681 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265603AbTBKB3r>;
	Mon, 10 Feb 2003 20:29:47 -0500
Date: Tue, 11 Feb 2003 01:35:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Crispin Cowan <crispin@wirex.com>, linux-security-module@wirex.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030211013521.GA23638@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Bill Davidsen <davidsen@tmr.com>, Crispin Cowan <crispin@wirex.com>,
	linux-security-module@wirex.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E471F21.4010803@wirex.com> <Pine.LNX.3.96.1030210170713.29699C-101000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030210170713.29699C-101000@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 05:14:50PM -0500, Bill Davidsen wrote:

 > Too radical? After the modules rewrite how could anything short of a
 > rewrite in another language be too radical.

The modules rewrite highlighted a *lot* of bugs, which had nothing
to do with modules whatsoever. It was unfortunate for Rusty that his
work got merged the same time as a lot of other changes went in
which broke a lot of stuff (The cli/sti stuff springs to mind).
It also highlighted another bunch of bugs which were *real problems*
like using code marked __init after it was freed.

The "This doesn't compile, Rusty sucks" brigade then appeared,
not taking a second to realise that said driver was fscked regardless
of Rusty's code being merged.

Sure the modules rewrite wasn't painless, and like everything that
gets merged, there were bugs, but give the guy a break already.[1]
If there are still problems with modules, let Rusty know about it.
If not, please STFU already, its getting tiring hearing the same
old FUD.

		Dave

[1] Or would you prefer he renamed the firewall tools again? (SRustyCNR)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
