Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280474AbRKKTUt>; Sun, 11 Nov 2001 14:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280467AbRKKTUk>; Sun, 11 Nov 2001 14:20:40 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:37825
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S280474AbRKKTUe>; Sun, 11 Nov 2001 14:20:34 -0500
Date: Sun, 11 Nov 2001 15:08:14 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: The 1.8.3 version of CML2 is available
Message-ID: <20011111150814.A27640@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been off doing other things since August, but with the 2.5 fork actually
looking like a near-term proposition it seemed time to bring CML2 up to date.

Release 1.8.3: Sun Nov 11 14:50:48 EST 2001
	* Resync with 2.4.15-pre2 (except for SH port).
	* Fix bluetooth rulebase bugs.

This fixes the Bluetooth config bugs several people reported.  There are
a couple of reports of minor UI and logic bugs which I have not yet resolved, 
those will be handled in release 1.9.

I'm waiting on a resync patch from Niibe Yutaka for the SH port.

I've added some automated coverage checking to kxref which allows me
to state with certainty that every CML1 symbol is covered by the CML2
rulebase.  My next task will be to improve the coverage tools so I can
use them to garbage-collect symbols and rules out of the CML2 rulebase
that are no longer used in CML1.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Ideology, politics and journalism, which luxuriate in failure, are
impotent in the face of hope and joy.
	-- P. J. O'Rourke
