Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbRDRNUR>; Wed, 18 Apr 2001 09:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135172AbRDRNUK>; Wed, 18 Apr 2001 09:20:10 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:60421 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135170AbRDRNUA>;
	Wed, 18 Apr 2001 09:20:00 -0400
Date: Wed, 18 Apr 2001 09:20:26 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "'Eric S. Raymond'" <esr@snark.thyrsus.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Supplying missing entries for Configure.help, part 3
Message-ID: <20010418092026.D16765@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"'Eric S. Raymond'" <esr@snark.thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
	axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <E6FE4E054F02D511818E00025558B61D4B0A73@cluster01.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E6FE4E054F02D511818E00025558B61D4B0A73@cluster01.axis.se>; from peter.kjellerstedt@axis.com on Wed, Apr 18, 2001 at 09:03:12AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Kjellerstedt <peter.kjellerstedt@axis.com>:
> Would it not be better to teach your URL extractor (as I guess that
> is the reason for this patch) what a URL followed by a period and a
> space looks like. Even though they are legal URLs, I think we can
> safely assume the writer intended the period to end the sentence and
> not be part of the URL. The same goes for URLs followed by other
> characters like comma, colon and so on.

Of course it would be.  But I'm not yet sure it's practical; CML2's tokenizing
is actually being done by the Tk text widget and I have yet to discover
whether it can be told to discard the trailing period.

Note however that I didn't introduce these spaces for CML2 but to conform a
few exceptions to practice in the CML1 file.  My own choice would be to wrap
URLs and relative filenames in <> and treat those as delimeters, but I didn't
want to change the existing convention (yet).
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

There's a truism that the road to Hell is often paved with good intentions.
The corollary is that evil is best known not by its motives but by its
*methods*.
