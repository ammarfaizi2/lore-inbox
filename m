Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbUCTLgc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 06:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbUCTLgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 06:36:31 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:24723 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263376AbUCTLga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 06:36:30 -0500
Date: Sat, 20 Mar 2004 12:36:27 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Johannes Stezenbach <js@convergence.de>,
       Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040320113627.GB7714@merlin.emma.line.org>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Johannes Stezenbach <js@convergence.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <200403200102.39716.bzolnier@elka.pw.edu.pl> <20040320014837.GB11865@convergence.de> <200403200313.05681.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403200313.05681.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Correct answer is: everything is fine, RTFM (man hdparm). ;-)

Not everything is fine. hdparm documents -i returns inconsistent data.
Most, but _NOT_ _EVERYTHING_ is cached: the multcount is updated, for
instance. What is that good for? Mix & Match whatever is convenient?

Are there systems where -I will not work? If there are none, hdparm 6.0
should be shipped without the -i option.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
