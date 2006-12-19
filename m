Return-Path: <linux-kernel-owner+w=401wt.eu-S932915AbWLSVSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915AbWLSVSk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933000AbWLSVSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:18:40 -0500
Received: from outmx001.isp.belgacom.be ([195.238.5.51]:35067 "EHLO
	outmx001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915AbWLSVSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:18:39 -0500
Date: Tue, 19 Dec 2006 22:18:26 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: cleanup s3c2410_wdt probe and release
Message-ID: <20061219211826.GA2943@infomag.infomag.iguana.be>
References: <20061218103132.GA10691@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218103132.GA10691@home.fluff.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

> Cleanup the s3c2410_wdt driver's exit point by
> using labels instead of multiple returns. Also
> remove the checks for the resources having been
> allocate in the exit, as we will now either have
> fully allocated or not allocated the resources
> at-all.

Patch added to linux-2.6-watchdog-mm git tree.

Greetings,
Wim.

