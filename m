Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265066AbTLRLWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 06:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTLRLWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 06:22:12 -0500
Received: from ANancy-107-1-28-166.w81-51.abo.wanadoo.fr ([81.51.12.166]:31931
	"EHLO joebar.freealter.fr") by vger.kernel.org with ESMTP
	id S265066AbTLRLWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 06:22:12 -0500
Date: Thu, 18 Dec 2003 12:21:14 +0100
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple partition not detected with 2.6
Message-ID: <20031218112114.GA3074@joebar.freealter.fr>
References: <20031215141746.GA27006@joebar.freealter.fr> <20031215170517.GA12267@win.tue.nl> <20031217112046.GA31709@joebar.freealter.fr> <200312172055.50595.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312172055.50595.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
From: Ludovic Drolez <ludovic.drolez@linbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just found where the problem came from !

In fact I have more that one IDE controler on this PC,
and my 2.6 kernel was not compiled for supporting this IDE
raid chipset (CMD649).

Sorry for wasting your time.

Cheers,

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
152 rue de Grigy - Technopole Metz 2000                   57070 METZ
tel : 03 87 75 55 21                            fax : 03 87 75 19 26
