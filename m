Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281818AbRL0VCT>; Thu, 27 Dec 2001 16:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRL0VCK>; Thu, 27 Dec 2001 16:02:10 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:50107 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S281488AbRL0VB4>; Thu, 27 Dec 2001 16:01:56 -0500
Subject: replacing strtok() with strsep()
From: Philip Harvey <harveyp@coventry.ac.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 27 Dec 2001 21:04:05 +0000
Message-Id: <1009487046.8811.0.camel@arrakis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've decided its high time someone removed every last trace of strtok()
from the kernel source (replacing with strsep() for thread safety), so
i've decided to do it myself.  quite simple stuff, but requires
extensive testing to be sure.  therefore, i'm not too keen on patching
2.4.x, but instead cleaning out 2.5.x.  if someone else is doing this,
or has any objections, shout my way please.

cheers,
	phil

