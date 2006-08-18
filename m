Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWHRI2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWHRI2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWHRI2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:28:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7185 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751132AbWHRI2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:28:01 -0400
Date: Fri, 18 Aug 2006 08:27:37 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@lifl.fr>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
Message-ID: <20060818082736.GB7778@ucw.cz>
References: <200608102318.04512.thomas.koeller@baslerweb.com> <200608142126.29171.thomas.koeller@baslerweb.com> <20060817153138.GE5950@ucw.cz> <200608172230.30682.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608172230.30682.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-08-06 22:30:30, Thomas Koeller wrote:
> On Thursday 17 August 2006 17:31, Pavel Machek wrote:
> > Well, I guess v4l api will need to be improved, then. That is still
> > not a reason to introduce completely new api...
> 
> The API as implemented by the driver I submitted is very minimalistic,
> because it is just a starting point. There's more to be added in future,
> like controlling flashes, interfacing to line-scan cameras clocked by
> incremental encodes attached to some conveyor, and other stuff which
> is common in industrial image processing applications. You really do


If it is _common_, we definitely need an API. We do not want the next
driver to reinvent it from scratch, right?
-- 
Thanks for all the (sleeping) penguins.
