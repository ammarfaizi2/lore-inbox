Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUA1Dts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 22:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbUA1Dts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 22:49:48 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:35855 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S265841AbUA1Dtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 22:49:46 -0500
Date: Tue, 27 Jan 2004 19:49:39 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Trailing blanks in source files
Message-ID: <20040128034939.GE15979@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt.suse.lists.linux.kernel> <p73bropfdgl.fsf@nielsen.suse.de> <200401271251.34926.theman@josephdwagner.info> <20040127191358.GI20879@khan.acc.umu.se> <20040127111824.7f76efe6.rddunlap@osdl.org> <20040127160214.69850c9c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127160214.69850c9c.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content unsuitable for young readers.  Parental guidance is suggested.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 04:02:14PM -0800, Andrew Morton wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> >
> > So please don't bother with just whitespace changes unless you
> > are going to cleanup a <driver | fs | module | etc> completely.
> 
> And if you're going to do that, do the whitespace cleanup _first_, so the
> substantive changes to the driver/fs/module/etc can be sanely understood
> and reverted if necessary.
> 
> I frequently sneakily remove all newly-added trailing whitespace from the
> patches people send me.  In 15 years it'll all be gone.

This would maybe warrant a bk option to remove trailing
whitespace from modified lines.  Preferably with an
notification that it is happening so if for some reason you
do want trailing whitespace you could abort or override.

A patch filter that removed trailing whitespace from + lines
could also be used.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
