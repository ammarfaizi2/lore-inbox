Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTFJPYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTFJPYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:24:04 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:45559 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S263131AbTFJPVl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:21:41 -0400
Date: Tue, 10 Jun 2003 17:35:18 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xirc2ps_cs update
In-Reply-To: <200306101524.15648.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.44.0306101731200.10841-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003, Daniel Ritz wrote:

> -    busy_loop(HZ/25);		     /* wait 40 msec */
> +    Wait(HZ/25);		     /* wait 40 msec */

Why not Wait(40); instead Wait(HZ/25) ? Currently HZ is 1000. However, the
value can change - as it changed from 100 to 1000.

  Geller Sandor <wildy@petra.hos.u-szeged.hu>

