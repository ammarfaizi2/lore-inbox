Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281685AbRKUJJe>; Wed, 21 Nov 2001 04:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281686AbRKUJJW>; Wed, 21 Nov 2001 04:09:22 -0500
Received: from gate.mesa.nl ([194.151.5.70]:36105 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S281685AbRKUJJH>;
	Wed, 21 Nov 2001 04:09:07 -0500
Date: Wed, 21 Nov 2001 10:08:49 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: New ac patch???
Message-ID: <20011121100849.D15851@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <Pine.LNX.4.30.0111202146260.17569-100000@mustard.heime.net> <E166KTa-00036Z-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E166KTa-00036Z-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 20, 2001 at 11:38:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


2.4.13-ac will "flushing ide drives" on shutdown. This helped my laptop
from not '/dev/hdax no cleanly unmounted, checking' on startup. I'm sure
the system did not crash before that.

2.4.15-pre6 does not have this code and now sometimes some filesystems
seem not to be clean anymore on startup...

Will the ide_notify_reboot be included in 2.4.15 final?

-Marcel

On Tue, Nov 20, 2001 at 11:38:50PM +0000, Alan Cox wrote:
> > > to Linus that are 2.5 material (eg PnPBIOS). The only "-ac" patch as such
> > > would be for 32bit quota and other oddments so I don't think its worth the
> > > effort.
> > 
> > Will this include the patches to allow for /proc/sys/vm/(min|max)-readahead
> > soon?
> 
> Thats pretty low on my priority list. Its actually not a hard patch to
> extract although I'd prefer someone like Andrea who knows the new rather
> undocumented VM did the merge
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
