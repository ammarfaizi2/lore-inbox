Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWATQJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWATQJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWATQJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:09:39 -0500
Received: from gherkin.frus.com ([192.158.254.49]:24773 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1750953AbWATQJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:09:38 -0500
Subject: Re: RFC: OSS driver removal, a slightly different approach
In-Reply-To: <m3ek34vucz.fsf@defiant.localdomain> "from Krzysztof Halasa at Jan
 19, 2006 09:24:44 pm"
To: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 20 Jan 2006 10:09:32 -0600 (CST)
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060120160932.2CE10DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> > (...)
> > SOUND_PAS
> 
> Pro Audio Spectrum. Earlier than GUS? 8-bit I think

16-bit actually.  SoundBlaster emulation capability of various kinds
was claimed by the manufacturer, but I know of few cards of that era
that *didn't* make such claims :-).

> Don't you all think a large part (if not most) of the "ALSA-unsupported"
> cards is no longed in any (Linux-related) use? I wouldn't be surprised
> if they just don't exist anymore. Who is to write drivers for them and -
> more importantly - who can test them?

I can help out with the testing of the PAS, including the SCSI side of
the Pro Audio Studio version of the card (another can of worms that the
ALSA folks rightly have no responsibility for: it never really worked
well with Linux because the driver supported the NCR chipset in polling
mode only).

As far as other old ISA soundcards I might be able to help test, I also
have a GUS with the multiple proprietary CD-ROM interfaces on it, and a
MAUI -- the latter being in a semi-modern PIII/1000 machine running FC4.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
