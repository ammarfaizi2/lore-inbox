Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292421AbSBPQe4>; Sat, 16 Feb 2002 11:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292424AbSBPQeq>; Sat, 16 Feb 2002 11:34:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22277 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292421AbSBPQeb>;
	Sat, 16 Feb 2002 11:34:31 -0500
Message-ID: <3C6E8A15.D5C209B1@mandrakesoft.com>
Date: Sat, 16 Feb 2002 11:34:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Possible breakthrough in the CML2 logjam?
In-Reply-To: <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215213833.J27880@suse.de> <1013810923.807.1055.camel@phantasy> <20020215232832.N27880@suse.de> <3C6DE87C.FA96D1D6@mandrakesoft.com> <20020216095202.M23546@thyrsus.com> <3C6E7C75.A6659D72@mandrakesoft.com> <20020216105219.A31001@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> But for these good things to happen, CML2 *got to go in*.  I cannot both
> continue the enormous effort of maintaining a parallel rulebase
> and move the ball forward towards automatic rule generation from metadata
> and other good things.  That's what I want to be working on.

Global dependencies...  CML1 doesn't have this now, and it needs never
to have it.  This is no point in merging a design change of that
magnitude only to take it away later on.  Further, merging a rulebase
which contains such dependencies would be a huge mistake that might take
years to undo.  drivers/net/rules.cml doesn't need S/390 stuff in it,
AFAICT, and that is a simple example of a bug found in many of the
rules.cml files.

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
