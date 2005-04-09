Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVDIBWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVDIBWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVDIBWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:22:40 -0400
Received: from ds01.webmacher.de ([213.239.192.226]:684 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261234AbVDIBWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:22:33 -0400
In-Reply-To: <20050409010919.GA10215@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <29524f727cac1be01c35cafa3409c2e3@dalecki.de> <20050409010919.GA10215@taniwha.stupidest.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <650190685e52c4a68c7c53f23bcd81b8@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: Kernel SCM saga..
Date: Sat, 9 Apr 2005 03:21:49 +0200
To: Chris Wedgwood <cw@f00f.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-04-09, at 03:09, Chris Wedgwood wrote:

> On Sat, Apr 09, 2005 at 03:00:44AM +0200, Marcin Dalecki wrote:
>
>> Yes it sucks less for this purpose. See subversion as reference.
>
> Whatever solution people come up with, ideally it should be tolerant
> to minor amounts of corruption (so I can recover the rest of my data
> if need be) and it should also have decent sanity checks to find
> corruption as soon as reasonable possible.

Yes this is the reason subversion is moving toward an alternative 
back-end
based on a custom DB mapped closely to the file system.

