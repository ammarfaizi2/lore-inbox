Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282815AbRLKURX>; Tue, 11 Dec 2001 15:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282819AbRLKURO>; Tue, 11 Dec 2001 15:17:14 -0500
Received: from miami.integratus.com ([192.111.50.240]:8433 "HELO
	mail.integratus.com") by vger.kernel.org with SMTP
	id <S282815AbRLKUQ7>; Tue, 11 Dec 2001 15:16:59 -0500
Message-ID: <3C166920.77F644F@integratus.com>
Date: Tue, 11 Dec 2001 12:14:24 -0800
From: curtis@integratus.com
Organization: Integratus, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Hans Reiser <reiser@namesys.com>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributesinterface)
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com>
	 <20011207202036.J2274@redhat.com>
	 <20011208155841.A56289@wobbly.melbourne.sgi.com>
	 <3C127551.90305@namesys.com>
	 <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know I'm stepping into a minefield, but I just can't help putting in
my 2 pennies.  :-)

Anton Altaparmakov wrote:
> At 12:02 11/12/01, Hans Reiser wrote:
> >What would have happened if set theory had not just sets and elements, but
> >sets, elements, extended-attributes, and streams, and you could not use
> >the same operators on streams that you use on elements?  It would have
> >been crap as a theoretical model.  It does real damage when you add things
> >that require different operators to the set of primitives. Closure is
> >extremely important to design.  Don't do this.
> 
> Since we are going into analogies: You don't use a hammer to affix a screw
> and neither do you use a screwdriver to affix a nail...at least I don't. I
> think you are trying to use a large sledge hammer to put together things
> which do not fit together thus breaking them in the process. To use your
> own words: Don't do this. (-; Each is distinct and should be treated as
> such. </me ducks>

I agree with Anton.  Files have certain characteristics that we all
know and love, stream-style attributes have pretty-much those same
characteristics.  IMHO, we would like EAs to have a different set of
characteristics so that the application programmer has different tools
in her toolbox.  To continue the analogy: "if all you have is a hammer,
everything looks like a nail".  Give someone that _already has_ a hammer
a screwdriver and they will be confused for a while but will end up
happier than if you gave them a "better hammer".

Thanks,

	Curtis

-- 
Curtis Anderson						curtis@integratus.com
