Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTKIGWI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 01:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTKIGWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 01:22:07 -0500
Received: from zeus.kernel.org ([204.152.189.113]:32708 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262188AbTKIGWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 01:22:01 -0500
Date: Mon, 3 Nov 2003 07:44:54 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: Re: [patch] reproducible athlon mce fix
Message-ID: <20031102234454.GA8409@anakin.wychk.org>
References: <20031102055748.GA1218@anakin.wychk.org> <20031102182556.GA4974@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
In-Reply-To: <20031102182556.GA4974@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 07:25:56PM +0100, Kronos wrote:

> In  this way  you don't  read  from bank  0. The strange  thing is  that



In any case:

(1) only does it for k7 (which seems to do the right thing)
(2) k7.c mcheck doesn't read from bank 0 as well

> amd_mcheck_init doesn't enable reporting on  this bank... it should stay
> clean. What's going on here?
> 


Notice how k7.c doesn't read from bank 0 either, and this was the fix 
submitted by Dave earlier on for k7.c but was not done for non-fatal.c.


	 - g.
-- 
\x42\x20\x70\x65\x6f\x70\x6c\x65\x20\x61\x72\x65\x20\x77\x61\x6e\x6b\x65\x72\x73
