Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030572AbWJaATY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbWJaATY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbWJaATY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:19:24 -0500
Received: from cantor2.suse.de ([195.135.220.15]:61933 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030572AbWJaATY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:19:24 -0500
From: Andi Kleen <ak@suse.de>
To: Horst Schirmeier <horst@schirmeier.com>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Date: Tue, 31 Oct 2006 01:19:10 +0100
User-Agent: KMail/1.9.5
Cc: Oleg Verych <olecom@flower.upol.cz>, Valdis.Kletnieks@vt.edu,
       Jan Beulich <jbeulich@novell.com>, dsd@gentoo.org, kernel@gentoo.org,
       draconx@gmail.com, jpdenheijer@gmail.com, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
References: <20061029120858.GB3491@quickstop.soohrt.org> <slrnekcu6m.2vm.olecom@flower.upol.cz> <20061031001235.GE2933@quickstop.soohrt.org>
In-Reply-To: <20061031001235.GE2933@quickstop.soohrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610310119.10567.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The problem is, this brings us back to the problem where this whole
> patch orgy began: Gentoo Portage sandbox violations when writing (the
> null symlink) to the kernel tree when building external modules. What
> about using $(M) as a base directory if it is defined?

I think Jan's $(objdir)/.tmp proposal would be cleanest. Just someone
has to implement it :)

-Andi
