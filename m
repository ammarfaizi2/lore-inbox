Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292410AbSBPQXQ>; Sat, 16 Feb 2002 11:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292408AbSBPQXL>; Sat, 16 Feb 2002 11:23:11 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:35336
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292405AbSBPQWm>; Sat, 16 Feb 2002 11:22:42 -0500
Date: Sat, 16 Feb 2002 10:56:08 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Rob Landley <landley@trommello.org>, Dave Jones <davej@suse.de>,
        Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216105608.B31986@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Rob Landley <landley@trommello.org>, Dave Jones <davej@suse.de>,
	Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020216085706.H23546@thyrsus.com> <20020216013538.A23546@thyrsus.com> <20020215135557.B10961@thyrsus.com> <20020215224916.L27880@suse.de> <20020215170459.A15406@thyrsus.com> <20020215232517.FXLQ71.femail38.sdc1.sfba.home.com@there> <20020216013538.A23546@thyrsus.com> <22614.1013851279@redhat.com> <20020216085706.H23546@thyrsus.com> <30686.1013871095@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <30686.1013871095@redhat.com>; from dwmw2@infradead.org on Sat, Feb 16, 2002 at 02:51:35PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> A good way to kill this myth, if myth it is, would be to set up a test 
> suite, as I suggested before. You already have a 'randomconfig' for CML2, I 
> believe? I think there's also one for CML1.

There is no randomconfig for CML2.
 
> Repeatedly make a random config (for a random architecture), with either
> CML1 or CML2. Make oldconfig with the other CML, then with the first again.
> If there are any differences between the original randomconfig output and
> the output after the two 'oldconfig' stages, you've hit something that may
> be a problem. 
> 
> Every time you hit such a difference, either fix it or document it and 
> justify it. Ensure that the list of such justifications required is small, 
> in order to improve the chance of CML2 being accepted. 

This cycle is what I've been going through with a lot of my beta testers.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
