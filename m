Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132343AbRCZGnL>; Mon, 26 Mar 2001 01:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132349AbRCZGnB>; Mon, 26 Mar 2001 01:43:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24296 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132343AbRCZGmu>;
	Mon, 26 Mar 2001 01:42:50 -0500
Message-ID: <3ABEE4C0.36EB75F5@mandrakesoft.com>
Date: Mon, 26 Mar 2001 01:42:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com> <15038.56527.591553.87791@wire.cadcamlab.org> <3ABEE0B5.12A2F768@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, bummer.  I can't seem to find Eric's message archived anywhere.

FWIW I am opposed to any large-scale cleanup of the configuration
language and/or identifiers in -any- 2.4.x series kernel.

Not only C code but installer utilities are affected by changes in the
CONFIG_xxx identifiers.  If we change that namespace, we are changing
part of the API that is exported to drivers.  Definitely not 2.4.x
stuff.

If we are moving to CML2 in 2.5, I see no point in big CML1 cleanups.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
