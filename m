Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbTIMRcA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTIMRb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:31:59 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3515 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261987AbTIMRb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:31:59 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 13 Sep 2003 19:31:57 +0200 (MEST)
Message-Id: <UTC200309131731.h8DHVvo24088.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] Re: [PATCH][IDE] update qd65xx driver
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As stated before you got corruption with hpt366.c because it was calling
> hpt3xx_tune_drive() *internally* with pio argument equal to 5 instead of 255.
>
> qd65xx.c is not calling qd*_tune_drive() internally et all -> no possibility
> of corruption unless user *manually* sets mode higher than supported.

OK, agreed.
