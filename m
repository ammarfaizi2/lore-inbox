Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVDHUuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVDHUuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 16:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVDHUuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 16:50:24 -0400
Received: from fmr22.intel.com ([143.183.121.14]:2214 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261899AbVDHUuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 16:50:11 -0400
Date: Fri, 8 Apr 2005 13:50:04 -0700
Message-Id: <200504082050.j38Ko4r19673@unix-os.sc.intel.com>
To: Linus Torvalds <torvalds@osdl.org>
From: Luck@unix-os.sc.intel.com, Tony <tony.luck@intel.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050408191638.GA5792@taniwha.stupidest.org>
References: <20050408041341.GA8720@taniwha.stupidest.org>
 <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random>
 <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de>
 <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org>
 <20050408180540.GA4522@taniwha.stupidest.org> <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
 <20050408191638.GA5792@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like an operation like "show me the history of mm/memory.c" will
be pretty expensive using git.  I'd need to look at the current tree, and
then trace backwards through all 60,000 changesets to see which ones had
actual changes to this file.  Could you expand the tuple in the tree object
to include a back pointer to the previous tree in which the tuple changed?
Or does adding history to the tree violate other goals of the tree type?

-Tony
