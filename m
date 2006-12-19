Return-Path: <linux-kernel-owner+w=401wt.eu-S932856AbWLSR4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbWLSR4p (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 12:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932861AbWLSR4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 12:56:45 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:56504 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932856AbWLSR4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 12:56:44 -0500
Date: Tue, 19 Dec 2006 18:53:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] kconfig: remove the unused "requires" syntax
In-Reply-To: <20061218180447.GF10316@stusta.de>
Message-ID: <Pine.LNX.4.64.0612191850220.1867@scrub.home>
References: <Pine.LNX.4.64.0612181138360.27491@localhost.localdomain>
 <20061218180447.GF10316@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Dec 2006, Adrian Bunk wrote:

> On Mon, Dec 18, 2006 at 11:41:59AM -0500, Robert P. J. Day wrote:
> > 
> >   Remove the note in the documentation that suggests people can use
> > "requires" for dependencies in Kconfig files.
> >...
> 
> Considering that noone uses it, what about the patch below to also 
> remove the implementation?

Mostly to keep the noise in the generated files low I prefer to just add 
some warning prints and I'll remove them later with some other syntax 
changes. This would also give external trees the chance to fix any 
possible usage first.

bye, Roman
