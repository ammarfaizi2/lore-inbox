Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbREQJ55>; Thu, 17 May 2001 05:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbREQJ5r>; Thu, 17 May 2001 05:57:47 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:63214 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261387AbREQJ5b>; Thu, 17 May 2001 05:57:31 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200105170957.LAA19756@sunrise.pg.gda.pl>
Subject: Re: make xconfig with tcl/tk 8.3 - the patches
To: simon.geard@ntlworld.com (Simon Geard)
Date: Thu, 17 May 2001 11:57:18 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01051710052900.01236@Granville> from "Simon Geard" at May 17, 2001 10:05:29 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Simon Geard wrote:"
> 
> Re my previous message on this subject, the patch files are attached.
> 
> They can also be found at my web site:
> 
> http://homepage.ntlworld.com/whiteowl/kernel

Unfortunately your patches break with older tk:

Error in startup script: couldn't compile regular expression pattern: nested
*?+
    while executing
"regexp {([0-9A-Za-z_]+)="(.*?)"} $line foo var value"
    (procedure "read_config" line 18)
    invoked from within
"read_config $defaults"
    (file "scripts/kconfig.tk" line 21611)
make: *** [xconfig] Error 1

I've checked tk-8.0 and 8.0.3.

Some other comments:
- please generate patches as universal diff (-uNr options for diff are
  preferred)
- please follow indentation rules used in a file you modify.
  {header,tail}.tk are tab-indented, not spaces.

Regards
    Andrzej

