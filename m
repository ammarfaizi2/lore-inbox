Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbRCFUnr>; Tue, 6 Mar 2001 15:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129469AbRCFUnh>; Tue, 6 Mar 2001 15:43:37 -0500
Received: from ns.suse.de ([213.95.15.193]:13836 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129466AbRCFUnc>;
	Tue, 6 Mar 2001 15:43:32 -0500
To: John Kodis <kodis@mail630.gsfc.nasa.gov>
Cc: Jeff Coy <jcoy@klah.net>, Peter Samuelson <peter@cadcamlab.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010306121510.A28368@cadcamlab.org>
	<Pine.LNX.4.10.10103061126490.27694-100000@aahz.klah.net>
	<20010306152628.A10091@tux.gsfc.nasa.gov>
X-Yow: Then, it's off to RED CHINA!!
From: Andreas Schwab <schwab@suse.de>
Date: 06 Mar 2001 21:43:24 +0100
In-Reply-To: <20010306152628.A10091@tux.gsfc.nasa.gov>
Message-ID: <jewva2iq6r.fsf@hawking.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Kodis <kodis@mail630.gsfc.nasa.gov> writes:

|> On Tue, Mar 06, 2001 at 11:36:29AM -0700, Jeff Coy wrote:
|> 
|> > '#!/usr/bin/perl -w^M' works without any special handling; the link is
|> > not needed:
|> 
|> This is the main reason that I think that the kernel should treat \r
|> as just another whitespace character: it's what most shells do

Do they?  Bourne shells don't, tcsh doesn't, zsh doesn't.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
