Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283856AbRLEJBt>; Wed, 5 Dec 2001 04:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283855AbRLEJBj>; Wed, 5 Dec 2001 04:01:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283858AbRLEJB0>; Wed, 5 Dec 2001 04:01:26 -0500
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
To: erich@uruk.org
Date: Wed, 5 Dec 2001 09:09:38 +0000 (GMT)
Cc: lm@bitmover.com (Larry McVoy), linux-kernel@vger.kernel.org
In-Reply-To: <E16BRNp-0003Ts-00@trillium-hollow.org> from "erich@uruk.org" at Dec 04, 2001 06:02:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BY3e-0005S9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For example, there should be no reason that most drivers or any other
> random kernel module should know anything about SMP.  Under Linux, it
> annoys me to no end that I have to ever know (and yes, I count compiling
> against "SMP" configuration having to know)...  more and more sources of
> error.

Unfortunately the progression with processors seems to be going the
wrong way. Spin locks are getting more not less expensive. That makes
CONFIG_SMP=n a meaningful optimisation for the 99%+ of people not running
SMP


Alan
