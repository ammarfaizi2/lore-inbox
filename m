Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270982AbTGVS0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270981AbTGVS0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:26:42 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:51719 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270982AbTGVS0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:26:41 -0400
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: Tom Felker <tcfelker@mtco.com>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kirby <sim@netnation.com>
In-Reply-To: <20030722180442.6c116e1c.martin.zwickel@technotrend.de>
References: <bUil.2D8.11@gated-at.bofh.it>
	 <pan.2003.07.22.15.14.44.457281@mtco.com>
	 <20030722180442.6c116e1c.martin.zwickel@technotrend.de>
Content-Type: text/plain
Message-Id: <1058899302.733.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 20:41:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-22 at 18:04, Martin Zwickel wrote:
> I have the same problem with 2.6.0-t1-ac2. If I minimize a
> window, my xmms hangs for a few ms. Same if I browse on some pages and go
> back/forward.
> The screen/windows also fills/draws a little bit slow. (well,
> could be a X/nvidia problem)
> 
> I changed back to 2.4.22-p7 and everything works fine.

Could you please test 2.6.0-test1-mm2? It includes some scheduler fixes
from Con Kolivas that will help in reducing or eliminating your
starvation issues.

Thank you very much!

