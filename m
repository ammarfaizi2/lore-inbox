Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284245AbRLPF2N>; Sun, 16 Dec 2001 00:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284244AbRLPF2E>; Sun, 16 Dec 2001 00:28:04 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:21896
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S284246AbRLPF1t>; Sun, 16 Dec 2001 00:27:49 -0500
Date: Sun, 16 Dec 2001 00:16:52 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Cc: torvalds@transmeta.com
Subject: Configure.help has complete coverage for 2.4 and 2.5.
Message-ID: <20011216001652.A18497@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
	torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For only the second time in recorded history, the master
Configure.help file now has help entries corresponding to *all*
configuration symbols in live use in the kernel tree (both 2.4 and
2.5).  It is available for your downloading pleasure at:

	http://tuxedo.org/~esr/cml2/Configure.help.gz

Fossil entries in this version have been garbage-collected out (I'm
keeping them in a dead-entries file in case any of them becomes
interesting again.)  Entries for which the question symbol has merely
been commented out in CML1 have been retained.

I had to write over 600 of the entries in this version myself,
including the last six.  Please don't put me through that again --
when you add a config option, *include a Configure.help entry in your
patch*.  Not documenting how and why to configure your option is both
sloppy and antisocial.  I beseech the current Elder Gods of the kernel
to reject future patches that neglect this step.

Thanks to everyone who responded well to my nagging by sending in entries.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Strict gun laws are about as effective as strict drug laws...It pains
me to say this, but the NRA seems to be right: The cities and states
that have the toughest gun laws have the most murder and mayhem.
        -- Mike Royko, Chicago Tribune
