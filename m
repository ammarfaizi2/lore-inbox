Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132354AbRCZHCv>; Mon, 26 Mar 2001 02:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132355AbRCZHCc>; Mon, 26 Mar 2001 02:02:32 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:34536 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132354AbRCZHCY>;
	Mon, 26 Mar 2001 02:02:24 -0500
Message-ID: <3ABEE953.AA8FD984@mandrakesoft.com>
Date: Mon, 26 Mar 2001 02:01:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
Cc: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com> <15038.56527.591553.87791@wire.cadcamlab.org> <3ABEE0B5.12A2F768@mandrakesoft.com> <20010326014913.B11181@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> I don't care, as long as the result has a non-numeric
> prefix -- bare "8139whatever" is out.

Bullshit.  Numeric prefixes work fine in CML1.

With regards to CML2, hardware and driver filenames quite often begin
with numerals, so it is quite logical that config variables may begin
with a numeral.

You're writing CML2.  Don't create a stupid namespace with stupid
limitations.  I'm glad my filesystem and my sysctl namespace don't have
such limitations.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
