Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVHAUmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVHAUmD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVHAUjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:39:42 -0400
Received: from graphe.net ([209.204.138.32]:25303 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261241AbVHAUgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:36:52 -0400
Date: Mon, 1 Aug 2005 13:36:46 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Richard Purdie <rpurdie@rpsys.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <1122926537.7648.105.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508011335090.7011@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> 
 <1122860603.7626.32.camel@localhost.localdomain>  <Pine.LNX.4.62.0508010908530.3546@graphe.net>
 <1122926537.7648.105.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Richard Purdie wrote:

> > Is this related to the size of the process? Can you do a successful kernel 
> > compile w/o X?
> 
> Its an embedded device and lacks development tools to test that. I ran
> some programs which abuse malloc and the process would quite happily hit
> oom so it looks like something more is needed to trigger the bug...

Could you get me some more information about the hang? A stacktrace would 
be useful.

Well the device is able to run X so I guess that a slow kernel compile 
would work. At least the embedded device that I used to work on was 
capable of doing that (but then we had Debian on that thing which made 
doing stuff like that very easy).

