Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVJYRQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVJYRQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVJYRQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:16:48 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:19952 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932214AbVJYRQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:16:47 -0400
Date: Tue, 25 Oct 2005 10:16:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Olivier MATZ <zer0@droids-corp.org>, linux-kernel@vger.kernel.org
Subject: Re: Makefile : can I use both 'O=' and 'M=' ?
Message-ID: <20051025171646.GF26475@smtp.west.cox.net>
References: <435DE018.5000902@droids-corp.org> <23145.194.237.142.24.1130227295.squirrel@194.237.142.24>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23145.194.237.142.24.1130227295.squirrel@194.237.142.24>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 10:01:35AM +0200, Sam Ravnborg wrote:
> > Hi all,
> >
> > When compiling an external module, is it possible to use both 'O=...'
> > and 'M=...' in the make command line ?
> 
> Hi Oliver.
> 
> O=... is used to tell kbuild where the output of the kernel compile is
> placed.
> There is no support for specifying a separate object directory when
> compiling external modules.

Perhaps he wants something like
make O=... SUBDIRS="$SUBDIRS ...." to compile the normal kernel + an
external module located elsewhere?

-- 
Tom Rini
http://gate.crashing.org/~trini/
