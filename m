Return-Path: <linux-kernel-owner+w=401wt.eu-S964976AbXABWXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXABWXw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXABWXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:23:51 -0500
Received: from pasmtpb.tele.dk ([80.160.77.98]:36096 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964976AbXABWXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:23:51 -0500
X-Greylist: delayed 1444 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 17:23:51 EST
Date: Tue, 2 Jan 2007 22:59:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc2-mm1:  Makefile drops local version when checking headers
Message-ID: <20070102215940.GA14868@uranus.ravnborg.org>
References: <1167755015.5104.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167755015.5104.2.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 11:23:35AM -0500, Lee Schermerhorn wrote:
> When building 2.6.20-rc2-mm1 with CHECK_HEADERS=y, the Makefile will
> build the target "include/config/kernel.release" twice.

I will try to take a look at this tomorrow.

> This behavior appears to have been introduced by the patch:
> 
> build-compileh-earlier.patch
Andrew anyway claimed there was a 2% chance he got it right so we hit the 98% case.

PS. Not on top of things yet but trying to recover and get time for Linux again.

	Sam
