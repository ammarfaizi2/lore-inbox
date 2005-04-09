Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVDIBNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVDIBNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVDIBMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:12:03 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:27638 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261231AbVDIBJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:09:41 -0400
Date: Fri, 8 Apr 2005 18:09:19 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050409010919.GA10215@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <29524f727cac1be01c35cafa3409c2e3@dalecki.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29524f727cac1be01c35cafa3409c2e3@dalecki.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 03:00:44AM +0200, Marcin Dalecki wrote:

> Yes it sucks less for this purpose. See subversion as reference.

Whatever solution people come up with, ideally it should be tolerant
to minor amounts of corruption (so I can recover the rest of my data
if need be) and it should also have decent sanity checks to find
corruption as soon as reasonable possible.

I've been bitten by problems that subversion didn't catch but bk did.
In the subversion case by the time I noticed much data was lost and
none of the subversion tools were able to recover the rest of it.

In the bk case, the data-loss was almost immediately noticeable and
only affected a few files making recovery much easier.
