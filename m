Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbTGIIlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 04:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265818AbTGIIh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 04:37:59 -0400
Received: from ns.tasking.nl ([195.193.207.2]:14856 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S265834AbTGIIhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 04:37:22 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre2 and pre3: compile error in aic7xxx
Organization: Altium SOFTWARE B.V.
References: <200307061135.00924.hans.lambrechts@skynet.be>
X-Face: "A(HPX!owGRCdtOX\NKs=ac*&x%/sYJMc;M<L&"^kH9ogp5;"w#UVc0yt3K{@n#.E+=k>qd bqZYYQvB9_xdS1l+B2\z;:p71RNxrja;ir>Dj?6%GzFA!o>gOL&G}8X;icnhqP|=TU,O@JVM%5LL:X ,G&IkRk9n%h7hZFUltu%RB=ctrdfu?[vSRV%Wzcn;#o>[K0C6_'q*~^+toc))w-Qb8*,afMHVCrNG6
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: kees.bakker@altium.nl (Kees Bakker)
Date: 09 Jul 2003 10:51:06 +0200
Message-ID: <sid6gkulqd.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.96
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Hans Lambrechts writes:
> 
> Hi 
> I got following error, gcc is version 3.3.

Good chance that you're on a SuSE 8.2 system. Although it says gcc 3.3 it
is in fact a beta of gcc 3.3. I was told (by Adrian Bunk) that the final
version 3.3 does not give these warnings. And remember, there is a -Werror
in the Makefile which makes the compilation to give an exit code 1 in case
of warnings.

		Kees

