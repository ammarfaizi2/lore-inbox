Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbUA1Exw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 23:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265856AbUA1Exw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 23:53:52 -0500
Received: from mail.timesys.com ([65.117.135.102]:62027 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S265852AbUA1Exv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 23:53:51 -0500
Subject: Re: RFC: Trailing blanks in source files
From: Pragnesh Sampat <pragnesh.sampat@timesys.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org, rv@gnu.org
In-Reply-To: <20040127195558.342dba6c.rddunlap@osdl.org>
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt.suse.lists.linux.kernel>
	 <p73bropfdgl.fsf@nielsen.suse.de>
	 <200401271251.34926.theman@josephdwagner.info>
	 <20040127191358.GI20879@khan.acc.umu.se>
	 <20040127111824.7f76efe6.rddunlap@osdl.org>
	 <20040127160214.69850c9c.akpm@osdl.org> <20040128034939.GE15979@pegasys.ws>
	 <20040127195558.342dba6c.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1075265265.15186.13.camel@mail.sampatonline.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 27 Jan 2004 23:53:31 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2004 04:47:56.0640 (UTC) FILETIME=[E5C74E00:01C3E559]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | > I frequently sneakily remove all newly-added trailing whitespace from the
> | > patches people send me.  In 15 years it'll all be gone.
> | 
> | This would maybe warrant a bk option to remove trailing
> | whitespace from modified lines.  Preferably with an
> | notification that it is happening so if for some reason you
> | do want trailing whitespace you could abort or override.
> | 
> | A patch filter that removed trailing whitespace from + lines
> | could also be used.
> 
> AFAIK Andrew already uses a script to check for trailing spaces,
> and I do also.  Yes, it could be modified to be a conversion filter,
> but it doesn't happen frequently, and when it does, I want to let
> the poster know about it, so I like to have the evidence handy.  :)

Recent versions of emacs, for those that use it, have whitespace.el (for
cleaning up as you go along).  It can cleanup different kinds of
whitespace based on settings.  Check C-h f whitespace-describe for more
details.  Got used to that heavily at one point, these days I am kind of
neutral, sometimes I do it, sometimes I don't bother.

-Pragnesh

