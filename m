Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLPA1u>; Fri, 15 Dec 2000 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQLPA1k>; Fri, 15 Dec 2000 19:27:40 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:44816 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129319AbQLPA12>;
	Fri, 15 Dec 2000 19:27:28 -0500
Date: Sat, 16 Dec 2000 00:56:58 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Joe deBlaquiere <jadb@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
Message-ID: <20001216005658.W573@almesberger.net>
In-Reply-To: <20001215152137.K599@almesberger.net> <Pine.LNX.3.96.1001215090857.16439A-100000@tarot.mentasm.org> <20001215184644.R573@almesberger.net> <3A3A7F25.2050203@redhat.com> <20001215222707.T573@almesberger.net> <3A3AA21F.4060100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A3AA21F.4060100@redhat.com>; from jadb@redhat.com on Fri, Dec 15, 2000 at 04:58:39PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe deBlaquiere wrote:
> but actually the best thing about it is 
> that the compiler people of the work might make generating a proper 
> cross-toolchain less difficult by one or two magnitudes...

You have a point here ... particularly gcc-glibc interdependencies are
a little irritating (not sure if they still cause build failures - they
were great fun in egcs-1.1b)

> This way I can upgrade my host system from RH6.2 to RH7 and not worry 
> about compiler differences affecting my kernel builds for the various 
> projects I'm working on... including systems based on 2.0, 2.2 and 2.4...

Ah, you mean you _do_ use a different compiler, but you _don't_ have to
change the compiler you normally invoke with "gcc" ? I see.

> If anybody thinks gcc-2.96 messes up a 2.4 kernel, you should see what 
> happens when you compile 2.0.33 ;o).

I think a -Wall-as-of=2.7.2 might be convenient at times ;-)

- Werner (drifting off-topic :-( )

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
