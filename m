Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWAQSOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWAQSOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWAQSOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:14:38 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30476 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932257AbWAQSOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:14:37 -0500
Date: Tue, 17 Jan 2006 19:14:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mita@miraclelinux.com
Subject: Re: [patch 2.6.15-current] i386: multi-column stack backtraces
Message-ID: <20060117181416.GB8047@mars.ravnborg.org>
References: <20060116224234.5a7ca488.akpm@osdl.org> <9554.1137493329@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9554.1137493329@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 09:22:09PM +1100, Keith Owens wrote:
> >
> >Presumably this is going to bust ksymoops.  Also the various other custom
> >oops-parsers which people have written themselves.
> 
> Should not be a problem for ksymoops.  Most entries use this regex,
> where [ ] is optional.

In that case can we then remove the CONFIG option?
If needed to be configurable a commandline option could do it,
so one does not have to rebuild the kernel.

	Sam
