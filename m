Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWDXWJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWDXWJD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWDXWJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:09:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40853 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751098AbWDXWJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:09:02 -0400
Date: Tue, 25 Apr 2006 00:09:01 +0200
From: Martin Mares <mj@ucw.cz>
To: marty fouts <mf.danger@gmail.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-ID: <mj+md-20060424.220809.6996.atrey@ucw.cz>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <9f7850090604241450w885fa98v36657ba5f12f071c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f7850090604241450w885fa98v36657ba5f12f071c@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Oh, and yeah, a = b + c *is* more readable than
> 
> a = malloc(strlen(b) + strlen(c));
> strcpy(a,b);
> strcat(a,c);
> 
> and contains fewer bugs ;)

Actually, it contains at least the bug you have made in your C example,
that is forgetting that malloc() can fail. So can string addition, if
allocated dynamically.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"This quote has been selected randomly. Really." -- M. Ulrichs
