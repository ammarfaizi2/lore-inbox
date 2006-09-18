Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWIRL67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWIRL67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 07:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWIRL67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 07:58:59 -0400
Received: from nef2.ens.fr ([129.199.96.40]:65288 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S964978AbWIRL66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 07:58:58 -0400
Date: Mon, 18 Sep 2006 13:58:50 +0200
From: David Madore <david.madore@ens.fr>
To: Joshua Brindle <method@gentoo.org>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060918115850.GA24548@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain> <450451DB.5040104@gentoo.org> <20060917181422.GC2225@elf.ucw.cz> <450DB274.1010404@gentoo.org> <20060917211602.GA6215@clipper.ens.fr> <1158579966.8680.24.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158579966.8680.24.camel@twoface.columbia.tresys.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Mon, 18 Sep 2006 13:58:50 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 07:46:06AM -0400, Joshua Brindle wrote:
> And that is just practical stuff, there are still problems with
> embedding policy into binaries all over the system in an entirely
> non-analyzable way, and this extends to all capabilities, not just the
> open() one.

Some people prefer the policy to be embedded into binaries all over
the system rather than centralized in one place.  I think it's just a
question of choice: if you don't like this way of doing things, you
don't have to use it, of course (my "cuppabilities" module would be
entirely optional).

Happy hacking,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
