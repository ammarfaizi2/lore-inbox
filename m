Return-Path: <linux-kernel-owner+w=401wt.eu-S1755346AbXABQKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbXABQKE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbXABQKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:10:03 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41327 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755345AbXABQKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:10:01 -0500
Date: Tue, 2 Jan 2007 08:09:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
In-Reply-To: <20070101212640.7268fb1d@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0701020807270.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
 <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
 <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org> <20070101212640.7268fb1d@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Jan 2007, Alan wrote:
> 
> If you revert the commit you end with all the PCI resource tree breakage
> back

Which weren't a regression or anything new.

Alan: regressions are what we don't do. Ever. If your second patch is 
found to have some other problems, we revert them both. It's that simple. 
It's better to stay in place than walk backwards, even if the "backwards" 
is just for a few people.

So far, it fixed at least Alessandro's problems, so here's to hoping there 
aren't any others..

		Linus
