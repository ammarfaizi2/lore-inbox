Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVARNDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVARNDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 08:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVARNDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 08:03:48 -0500
Received: from astro.systems.pipex.net ([62.241.163.6]:39585 "EHLO
	astro.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261289AbVARNDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 08:03:45 -0500
Date: Tue, 18 Jan 2005 13:04:37 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@ezer.homenet
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@muc.de>, Arjan van de Ven <arjan@infradead.org>,
       Jan Hubicka <jh@suse.cz>, Jack F Vogel <jfv@bluesong.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
In-Reply-To: <Pine.LNX.4.61.0501181112120.2911@ezer.homenet>
Message-ID: <Pine.LNX.4.61.0501181303400.2911@ezer.homenet>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
 <20050114205651.GE17263@kam.mff.cuni.cz> <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
 <cs9v6f$3tj$1@terminus.zytor.com> <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
 <1105955608.6304.60.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0501171002190.4644@ezer.homenet>
 <41EBFF87.6080105@zytor.com> <m1wtubvm8y.fsf@muc.de> <41EC224D.5080204@zytor.com>
 <Pine.LNX.4.61.0501181112120.2911@ezer.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, Tigran Aivazian wrote:
> I already solved this paricular problem. And the solution is (but don't tell 
> me you knew it, for then why didn't you tell anyone) simply --- compile the 
> kernel with -g and that includes enough debug information to be able to 
> decode the stack content correctly. And yes, kdb does show the correct 
> argument values now. No changes to kdb are necessary and no need to do the 
> work with dwarf2 implementation etc etc.

actually I am very surprized that it worked (because looking at the code I 
concluded that it should NOT). So I need to retest in all cases to make 
sure this is not a coincidence but a solid fact...

Kind regards
Tigran
