Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132429AbRCZL6d>; Mon, 26 Mar 2001 06:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132428AbRCZL6W>; Mon, 26 Mar 2001 06:58:22 -0500
Received: from mercury.ccil.org ([192.190.237.100]:15374 "EHLO
	mercury.ccil.org") by vger.kernel.org with ESMTP id <S132423AbRCZL6Q>;
	Mon, 26 Mar 2001 06:58:16 -0500
Subject: Re: [kbuild-devel] Re: CML1 cleanup patch
In-Reply-To: <20010326013228.A11181@thyrsus.com> from "Eric S. Raymond" at "Mar
 26, 2001 01:32:28 am"
To: esr@thyrsus.com
Date: Mon, 26 Mar 2001 06:57:48 -0500 (EST)
CC: Peter Samuelson <peter@cadcamlab.org>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E14hVd6-0007eK-00@mercury.ccil.org>
From: John Cowan <cowan@mercury.ccil.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

esr scripsit:

> I could have done this, allowing tokens to be recognized as numeric only
> if all chars are digits.  I didn't, for two reasons: (1) Lexical analysis
> is, as it turns out, a hotspot in the CML2 compiler code -- the last thing
> it needs is more overhead, and (2) interpreting symbols with leading digits
> as nonnumeric tokens is just *wrong*.  Ugh.  Violates the Principle of Least
> Surprise big-time.

In fact this has come up before: in Usenet software, which has to differentiate
between an article and a sub-newsgroup.  An article has to have an all-numeric
name, and It Would Have Been Nice if all newsgroup names began with non-digits,
but then there was comp.bugs.4bsd.

-- 
John Cowan                                   cowan@ccil.org
One art/there is/no less/no more/All things/to do/with sparks/galore
	--Douglas Hofstadter
