Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbREUMQf>; Mon, 21 May 2001 08:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261202AbREUMQZ>; Mon, 21 May 2001 08:16:25 -0400
Received: from t2.redhat.com ([199.183.24.243]:39928 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261165AbREUMQK>; Mon, 21 May 2001 08:16:10 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <l03130304b72ea286711e@[192.168.239.105]> 
In-Reply-To: <l03130304b72ea286711e@[192.168.239.105]>  <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com> 
To: Jonathan Morton <chromi@cyberspace.org>
Cc: Helge Hafting <helgehaf@idb.hist.no>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 May 2001 13:15:23 +0100
Message-ID: <18583.990447323@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


chromi@cyberspace.org said:
>  Having now briefly looked at the language constructs first-hand, I
> can see two ways to go about this:

> 1) Have a HACKER symbol which unsuppresses the "unusual" options, and
> suppresses the "generalised" ones 

> 2) Have a HACKERS submenu system which contains all the derivations
> that could *possibly* be un-defaulted, and allow our intrepid hacker
> to explicitly force each to a value or leave unset.

I prefer the former, which is how it's already implemented in CML1.

But the discussion of this is entirely unrelated to the discussion of CML2, 
and changes along these lines must not be forced into the kernel with the 
CML2 patch.

If ESR is going to sneak policy changes into the kernel with the CML2 
mechanism patch, I'm sure we all have patches we'd like him to add to it 
too, because we don't want to have to justify them on their own. :)

--
dwmw2


