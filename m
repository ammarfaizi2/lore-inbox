Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbQJ0UDV>; Fri, 27 Oct 2000 16:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130173AbQJ0UDM>; Fri, 27 Oct 2000 16:03:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:4367 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130006AbQJ0UDB>; Fri, 27 Oct 2000 16:03:01 -0400
Message-ID: <39F9DF5F.F5E6E4B8@transmeta.com>
Date: Fri, 27 Oct 2000 13:02:39 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu detection fixes for test10-pre4
In-Reply-To: <200010271946.e9RJk6K01211@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> "H. Peter Anvin" <hpa@transmeta.com>said:
> > Alan Cox wrote:
> 
> [...]
> 
> > > > We should never have used anything but "i386" as the utsname... sigh.
> 
> > > Its questionable if we should include the 'i'
> 
> > True enough, personally I prefer "x86".
> 
> ia32 is the official name. OTOH, i[3-6]86 _are_ different beasts...
> 

IA32 is a retcon, and is used only by Intel anyway.  There are
differences between the i686 lines that are significantly bigger than
between the i486 and i586, and that doesn't even begin to count non-Intel
chips.

However, changing it to "i386" consistently would still work with
existing software.  Using "x86" or "ia32" or "ix86pc" (what Solaris calls
it) would break stuff.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
