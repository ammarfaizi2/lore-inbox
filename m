Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290639AbSBLAXb>; Mon, 11 Feb 2002 19:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290636AbSBLAXX>; Mon, 11 Feb 2002 19:23:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48656 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290639AbSBLAXO>;
	Mon, 11 Feb 2002 19:23:14 -0500
Message-ID: <3C686066.91B06D84@mandrakesoft.com>
Date: Mon, 11 Feb 2002 19:23:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Mann <mainlylinux@attbi.com>
CC: Jaroslav Kysela <perex@perex.cz>,
        ALSA development <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: ALSA patch for 2.5.4
In-Reply-To: <Pine.LNX.4.31.0202111429270.500-100000@pnote.perex-int.cz> <1013472766.19794.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Mann wrote:
> On Mon, 2002-02-11 at 09:16, Jaroslav Kysela wrote:
> >       I repeat myself but anyway. We are open to any suggestions and
> > ideas for this kernel integration patch. Unfortunately, Linus has not
> > approved this directory tree and he is not talking with us at the time.
> > It seems that BIO changes are over, but he's probably busy enough to
> > ignore our e-mails with co-operation requests.

> There are at least 2 reasons that I can see why Linus probably won't
> accept your patch:
> 
>         1. It is not an inline text attachment (it is a URL).
>         2. It is 79,000 lines long

Well, merging ALSA is going to be one big mother of a patch no matter
how you slice it :)

But I agree, it would be nice for the patch to be broken up into steps,
ie. first patch moves OSS drivers into new location, second patch adds
infrastructure, third patch adds the 1001 drivers that ALSA supports :)

Also if the ALSA guys wanted to experiment with BK, that would be a
great way to do the merge.

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
