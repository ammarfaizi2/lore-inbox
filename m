Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWHRXcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWHRXcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWHRXcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:32:04 -0400
Received: from mother.openwall.net ([195.42.179.200]:14012 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751590AbWHRXcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:32:03 -0400
Date: Sat, 19 Aug 2006 03:27:58 +0400
From: Solar Designer <solar@openwall.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com, Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060818232758.GA10886@openwall.com>
References: <20060816223633.GA3421@hera.kernel.org> <20060818224814.GA10524@openwall.com> <20060818231115.GC7813@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818231115.GC7813@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Aug 19, 2006 at 02:48:14AM +0400, Solar Designer wrote:
> > We're about to migrate Openwall GNU/*/Linux (Owl) from its current gcc
> > 3.4.5 (which we used in our 2.0 release) to gcc 4+ - and we'd rather
> > _not_ migrate to Linux 2.6 at the same time, if we can.  We'd be more
> > comfortable migrating to Linux 2.6 a few months later.

On Sat, Aug 19, 2006 at 01:11:15AM +0200, Adrian Bunk wrote:
> Considering that it's really easy to compile the kernel with a different 
> compiler than the userland,

We want our end users to be able to rebuild all of Owl (including the
kernel) from source using only tools that are a part of Owl, yet we do
not want to be providing multiple versions of gcc (or of any other
package, for that matter).  We've been successful at not providing
multiple versions of development tools and libraries so far - keeping
the system small and clean, yet fully self-rebuildable.

> do you _really_ want to use such a 
> relatively untested kernel/gcc combination for a server platform?

I expect that we will fully move to Linux 2.6 before our next release,
but being able to move to gcc 4+ in Owl-current first simplifies our
development process.  (And, yes, we've got end users of Owl-current who
will be recompiling kernels.)

Also, I expect this kernel/gcc combination to receive quite some testing
soon, if/once it becomes supported.

Alexander
