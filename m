Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTLSQAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTLSQAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:00:54 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:24022 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263441AbTLSQAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:00:54 -0500
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ide.c as a module
References: <20031211202536.GA10529@starbattle.com>
	<200312121646.04047.bzolnier@elka.pw.edu.pl>
	<20031212171711.GA15954@starbattle.com>
	<200312121837.31121.bzolnier@elka.pw.edu.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 18 Dec 2003 01:29:35 +0100
In-Reply-To: <200312121837.31121.bzolnier@elka.pw.edu.pl> (Bartlomiej
 Zolnierkiewicz's message of "Fri, 12 Dec 2003 18:37:31 +0100")
Message-ID: <m3u13zynm8.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW: modular IDE in 2.4.23 is still problematic - you can't unload the
chipset driver (piix.o or something like) which in turn references the
core IDE module.

Is anyone working on it? I could probably fix it but I don't want to
duplicate the efforts.
-- 
Krzysztof Halasa, B*FH
