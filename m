Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283134AbRLDOoa>; Tue, 4 Dec 2001 09:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283433AbRLDOnE>; Tue, 4 Dec 2001 09:43:04 -0500
Received: from ns.caldera.de ([212.34.180.1]:55744 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S283415AbRLDNBv>;
	Tue, 4 Dec 2001 08:01:51 -0500
Date: Tue, 4 Dec 2001 14:00:50 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204140050.A10691@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	"Eric S. Raymond" <esr@thyrsus.com>, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204074815.A12231@thyrsus.com>; from esr@thyrsus.com on Tue, Dec 04, 2001 at 07:48:15AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 07:48:15AM -0500, Eric S. Raymond wrote:
> And, by the way, there is no CML1 :-).  Instead, there are four
> mutually incompatible dialects and a rulebase that breaks in different
> ways depending on which interpreter you use.  Well, maybe just three
> mutual incompatible dialects and one clone -- but it's notoriously
> hard to verify that two interpreters have the same accept language, so
> nobody knows for sure.

There is a CML1 language specification, as written down in a file, namely
Documentation/kbuild/config-language.txt in the kernel tree.
There is one tool (mconfig) which has a yacc-parser that implements that
specification completly, and some horrid ugly scripts in the tree that
parse them in a more or less working way.  There also are a number of
other tools I don't know to much about that understand the language as
well.

All of these tools just require the runtime contained in the LSB and no
funky additional script languages.  Also none needs a binary intermediate
representation of the config.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
