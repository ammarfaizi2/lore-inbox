Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVBOUgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVBOUgC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVBOUdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:33:46 -0500
Received: from centaur.culm.net ([83.16.203.166]:39172 "EHLO centaur.culm.net")
	by vger.kernel.org with ESMTP id S261875AbVBOU3z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:29:55 -0500
From: Witold Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: sil_blacklist - are all those entries necessary?
Date: Tue, 15 Feb 2005 21:29:10 +0100
User-Agent: KMail/1.7
References: <200502151706.04846.adasi@kernel.pl> <421228B7.2060204@pobox.com>
In-Reply-To: <421228B7.2060204@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502152129.11236.adasi@kernel.pl>
X-Spam-Score: -4.9 (----)
X-Scan-Signature: d6e44a17384f6889fd594fcbad19d6a2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia wtorek 15 luty 2005 17:52, napisa³e¶:
> Witold Krecicki wrote:
> > in sata_sil.c there is:
> > sil_blacklist [] = {
> >         { "ST320012AS",         SIL_QUIRK_MOD15WRITE },
> >         { "ST330013AS",         SIL_QUIRK_MOD15WRITE },
> >         { "ST340017AS",         SIL_QUIRK_MOD15WRITE },
> >         { "ST360015AS",         SIL_QUIRK_MOD15WRITE },
> >         { "ST380023AS",         SIL_QUIRK_MOD15WRITE },
> >         { "ST3120023AS",        SIL_QUIRK_MOD15WRITE },
> >         { "ST3160023AS",        SIL_QUIRK_MOD15WRITE },
> >         { "ST3120026AS",        SIL_QUIRK_MOD15WRITE },
> >         { "ST340014ASL",        SIL_QUIRK_MOD15WRITE },
> >         { "ST360014ASL",        SIL_QUIRK_MOD15WRITE },
> >         { "ST380011ASL",        SIL_QUIRK_MOD15WRITE },
> >         { "ST3120022ASL",       SIL_QUIRK_MOD15WRITE },
> >         { "ST3160021ASL",       SIL_QUIRK_MOD15WRITE },
> >         { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
> >         { }
> > };
> > I've got ST3120026AS and I've been using it with SIL3112 without this
> > hack for a long time - without any negative effects. The same impression
> > on ST3200822AS - is there any way to check if it is REALLY necessary?
> > 15MB/s is not what I'd expect on SATA...
>
> It's necessary until we can prove otherwise.  Simply running well
> without your drive in the blacklist means nothing -- you just haven't
> hit the error condition yet.
So how can I proove it? Are there any tests? It's been running for over a 
year, almost 24/7 and nothing...
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
