Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUF0Wlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUF0Wlf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 18:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUF0Wlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 18:41:31 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:4276 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264524AbUF0Wla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 18:41:30 -0400
Date: Sun, 27 Jun 2004 15:41:15 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040627224115.GA22532@taniwha.stupidest.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org> <1088290477.3790.2.camel@localhost.localdomain> <20040627000541.GA13325@taniwha.stupidest.org> <pan.2004.06.27.12.00.03.857572@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.06.27.12.00.03.857572@smurf.noris.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 02:00:03PM +0200, Matthias Urlichs wrote:

> <heretic>
>
> #define jiffies __get_jiffies()
>
> </heretic>

Well, I have that but it's only part of the story.

The real issue seems to be that a suitable clean API for drivers to
use rather than intenral knowledge of jiffies is lacking.

As Alan pointed out a suitable API could also make it easier to work
towards a clock-less system for embedded targets.


   --cw
