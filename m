Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVJFN2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVJFN2a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVJFN23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:28:29 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:22673 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750885AbVJFN23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:28:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Date: Thu, 6 Oct 2005 15:29:35 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@cyclades.com>
References: <20051002231332.GA2769@elf.ucw.cz> <200510061023.16016.rjw@sisk.pl> <20051006104247.GA25255@elf.ucw.cz>
In-Reply-To: <20051006104247.GA25255@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061529.36149.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 6 of October 2005 12:42, Pavel Machek wrote:
> Hi!
> 
> > > > OK, but if we decide to move some functions from one file to another,
> > > > we'll have to wait for another "settle down" period, I think.
> > > 
> > > Yes...
> > 
> > Then I'd propose that we wait for the next "settle down" period with the
> > split and apply all of the bugfixes and cleanups now.
> 
> Nigel's cleanup is not ready yet, and yours is oneliner. I applied
> that oneliner locally. I already have cleanups depending on the
> split. Of course I can redo them, but perhaps it is easier to just
> redo that one line.

OK

Just to make sure:
- the rework-image-freeing patch goes first,
- my x86-64 patch goes second,
- the splitting patch goes next,
and any subsequent cleanups are expected to go on top of it?

Rafael
