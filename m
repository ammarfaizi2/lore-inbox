Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbULHQ45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbULHQ45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 11:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbULHQ45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 11:56:57 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:17337 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261259AbULHQ4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 11:56:55 -0500
Subject: Re: Mach Speed motherboard w/onboard video
From: Lee Revell <rlrevell@joe-job.com>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200412081140.33199.gene.heskett@verizon.net>
References: <200412081140.33199.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 11:56:53 -0500
Message-Id: <1102525014.30593.17.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 11:40 -0500, Gene Heskett wrote:
> Has a builtin video, called UniCrome in the propaganda.
> 
> Are there usable linux drivers for this one?

Yes, they are quite good actually:

http://unichrome.sourceforge.net/

The biggest problem is that the via DRM module is not in the kernel yet.
You will have to install it from dri.sourceforge.net CVS.  It was in a
recent -mm release but was dropped and unfortunately the current version
doesn't work with the -mm kernel.  Andrew Morton & others have said they
will try to get it back in soon.

Lee

