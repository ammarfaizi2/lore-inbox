Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272485AbRIOSPV>; Sat, 15 Sep 2001 14:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272473AbRIOSPK>; Sat, 15 Sep 2001 14:15:10 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:39952 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272462AbRIOSOv>; Sat, 15 Sep 2001 14:14:51 -0400
Subject: Re: AGP Bridge support for AMD 761
From: Robert Love <rml@ufl.edu>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: Steven Spence <kwijibo@zianet.com>, DevilKin@gmx.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109151108510.26946-100000@windmill.gghcwest.com>
In-Reply-To: <Pine.LNX.4.33.0109151108510.26946-100000@windmill.gghcwest.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.18.39 (Preview Release)
Date: 15 Sep 2001 14:14:56 -0400
Message-Id: <1000577698.32706.32.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-15 at 14:09, Jeffrey W. Baker wrote:
> I've found, with 2.4.9(-ac9), that the lilo append line doesn't work at
> all.  agpgart *must* be a modules, or it won't work with 761.

Try my patch (just reposted as `[PATCH] AGP GART for AMD 761'), it will
enable the AGP GART to work with the 761 natively, so you can use it
without try_unsupported=1 and thus statically in the kernel or as a
module.

Please let me know if it works, as I don't have an AMD 761.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

