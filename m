Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133068AbRD3DWX>; Sun, 29 Apr 2001 23:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133102AbRD3DWM>; Sun, 29 Apr 2001 23:22:12 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:5129 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S133068AbRD3DV6>;
	Sun, 29 Apr 2001 23:21:58 -0400
Date: Sun, 29 Apr 2001 23:23:12 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.3.3 is available
Message-ID: <20010429232312.A3775@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 1.3.3: Sun Apr 29 23:00:33 EDT 2001
	* Resync with 2.4.4.
	* Help texts merged into symbols file; the `helpfile' declaration
	  is gone.  (Text is merged in from Documentation/Configure.help
	  at CML2 installation time.)
	* Tweaked the appearance of inactive help buttons by popular demand.

My clever plan worked.  Less than three hours after I pronounced 1.3.1
"stable", somebody turned in the first crash bug in three weeks.  Fortunately
it was pretty trivial to fix, a loose end from one of my speedups.  Fixed in
yesterday's 1.3.2.

The big news in this version is that all the help texts have been merged into
the CML2 rules files.  A typical symbol declaration now looks like this:

GONK_5523		'Support for B5523 adaptive gonkulator'	text
Say Y here to compile in support for the Bollix 5523 adaptive gonkulator.
.

Help texts are merged into the CML2 symbols file at CML2 installation time.
The `helpfile' declaration is gone.  Among other things, this means you no
longer need to run CML2 inside a kernel source tree; you can test the scripts 
anywhere.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

See, when the GOVERNMENT spends money, it creates jobs; whereas when the money
is left in the hands of TAXPAYERS, God only knows what they do with it.  Bake
it into pies, probably.  Anything to avoid creating jobs.
	-- Dave Barry
