Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129982AbRAZTSJ>; Fri, 26 Jan 2001 14:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131127AbRAZTR7>; Fri, 26 Jan 2001 14:17:59 -0500
Received: from mail.zmailer.org ([194.252.70.162]:27147 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129982AbRAZTRl>;
	Fri, 26 Jan 2001 14:17:41 -0500
Date: Fri, 26 Jan 2001 21:17:30 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126211730.L25659@mea-ext.zmailer.org>
In-Reply-To: <Pine.SOL.4.21.0101261528190.16539-100000@red.csi.cam.ac.uk>, <Pine.GNU.4.32.0101260850150.23316-100000@hanuman.oobleck.net> <94sg4o$1o4$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94sg4o$1o4$1@forge.intermeta.de>; from hps@tanstaafl.de on Fri, Jan 26, 2001 at 06:37:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 06:37:12PM +0000, Henning P. Schmiedehausen wrote:
... 
> Cisco: If I buy a _new_ PIIX oder LDIR today, do I get an ECN capable
> IOS or not? If not, will my CCNA know about this and upgrade my Box
> before deploying?

  That cisco box is called  PIX -- PIIX sounds like some intel thing..
  Current baseline binary contains ECN, and CCNA may or may not know it.

  Oh yes, PIX code is not IOS, it is something else -- because it wasn't
  Cisco product originally, but something what Cisco bought...

  I haven't followed up on what Local Directory product it, probably same
  PC hardware (+ disk) as PIX, but a bit different software suite.

> Everyone I know and their brothers, that use Cisco Equipment, have a
> support contract with Cisco. Why not push an "mandatory upgrade" along
> this path once the ECN leaves "experimental" status.

  Bruhaha...  PIX has MailGuard feature, which fucks up SMTP protocol
  royally in some old versions.  I see that buggy version still running
  deployed even though fixes were done back in May 1998 ...
  (http://www.zmailer.org/cisco-pix.html)

  Why do I see it ?  VGER's ZMailer uses extensively that "rare" extended
  SMTP feature which is where it happens, and my employer runs that same
  software in couple large ISP SMTP relays..

> 	Regards
> 		Henning

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
