Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281184AbRLDRE4>; Tue, 4 Dec 2001 12:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRLDRDa>; Tue, 4 Dec 2001 12:03:30 -0500
Received: from t2.redhat.com ([199.183.24.243]:37358 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S281165AbRLDRCY>; Tue, 4 Dec 2001 12:02:24 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3C0CFF5F.3090404@dplanet.ch> 
In-Reply-To: <3C0CFF5F.3090404@dplanet.ch>  <20011204111115.A15160@thyrsus.com> <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de> <19642.1007484062@redhat.com> 
To: Giacomo Catenazzi <cate@dplanet.ch>
Cc: esr@thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Dec 2001 17:02:17 +0000
Message-ID: <21945.1007485337@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cate@dplanet.ch said:
>  I don't think esr changed non problematic rules, but one: all rules
> without help become automatically dependent to CONFIG_EXPERIMENTAL. I
> don't like it, but I understand why he makes this decision. 

That is precisely the kind of bogus change which should _not_ be done in 
such an underhand way. 

With the exception of obvious and undisputed bug fixes, the behaviour of 
the first CML2 version should precisely match the behaviour of the last 
CML1 version.

If you want to make symbols without help depend on CONFIG_EXPERIMENTAL, 
submit the equivalent patch for CML1 and watch it get shot down in flames.

Then go away.

But don't let this dissuade you from doing something that's actually 
useful, like CML2 could be.

On the other hand, perhaps we could reach some kind of a deal.... Eric, if
you can manage to also sneak a kernel debugger past Linus as part of your
big-patch-which-hides-controversial-changes, I for one would be happy enough
to deal with the bogus config changes :)

--
dwmw2


