Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289355AbSAOCI5>; Mon, 14 Jan 2002 21:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289357AbSAOCIs>; Mon, 14 Jan 2002 21:08:48 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:8072
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289355AbSAOCIf>; Mon, 14 Jan 2002 21:08:35 -0500
Date: Mon, 14 Jan 2002 20:53:07 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020114205307.E24120@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020114165909.A20808@thyrsus.com> <20020114173542.C30639@redhat.com> <20020114173854.C23081@thyrsus.com> <20020114180007.D30639@redhat.com> <20020114180522.A24120@thyrsus.com> <20020114183820.G30639@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020114183820.G30639@redhat.com>; from bcrl@redhat.com on Mon, Jan 14, 2002 at 06:38:20PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@redhat.com>:
> FYI, it's easy to fix, just use the correct ordering of download, transmit, 
> delete that sendmail and other MTAs use.

I don't understand what you think you're seeing, but I am sure of
this; if I had been enough of a drug-addled lunatic to allow fetchmail
to delete mail before getting a positive acknowledge from the
downstream MTA, someone in the pool of over two thousand people who have sent
me bug reports and patches would have called me on it some time in the
six years of production use well before *you* entered the picture.

It's likely you're being hosed by an MTA that's sending back bogus 2xx
responses.  That's happend before.  Fetchmail can't magically cope
with MTAs that tell it lies.

Fetchmail *already works the way you recommend* -- as any idiot can
verify by reading the short section of the main driver loop where
dispatch and delete takes place.  That's been an invariant of the code
since day one, and you thus clearly have no bloody idea what you are
flaming about.

Don't take my word for it.  Go read the code.  Until you've done so,
I suggest you take it off-list before you embarrass yourself further.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A man who has nothing which he is willing to fight for, nothing 
which he cares about more than he does about his personal safety, 
is a miserable creature who has no chance of being free, unless made 
and kept so by the exertions of better men than himself. 
	-- John Stuart Mill, writing on the U.S. Civil War in 1862
