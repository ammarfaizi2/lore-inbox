Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282912AbRLQVmV>; Mon, 17 Dec 2001 16:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRLQVmL>; Mon, 17 Dec 2001 16:42:11 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:32681
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S282912AbRLQVlx>; Mon, 17 Dec 2001 16:41:53 -0500
Date: Mon, 17 Dec 2001 16:30:21 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: CML2 1,9.10 is available
Message-ID: <20011217163021.A16097@thyrsus.com>
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

Release 1.9.10: Mon Dec 17 16:23:01 EST 2001
	* Rulebase and help sync with 2.4.17-rc1/2.5.1.
	* Configure.help now covers every live symbol in these kernels.
	* SuperH port update by Niibe Yutaka.
	* Ooops...edit hex values in hex!
	* Rob Landley's UI changes in menuconfig.
	* Backed out Richard Todd's fix for dependent binding.  We found 
	  a case that broke it; Todd acknowledged the problem.
	* Compiler can now handle "suppress depend" on an "impure" guard,
	  that is one that contains disjunctions and other logical operations.
	* User is now warned when setting an invisible symbol that might 
	  not be saved out.

Richard Todd has found some theoretical problems with forcing of
ancestor symbols by a dependent.  These show up only when a change in 
multiple dependents of a symbol is made and one of the changes is later 
nacked out.  We're not aware of any cases in which these break the
behavior of the kernel ruleset, but this qualifies as a genuine bug 
which I will fix.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The abortion rights and gun control debates are twin aspects of a deeper
question --- does an individual ever have the right to make decisions
that are literally life-or-death?  And if not the individual, who does?
