Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265973AbSKBS32>; Sat, 2 Nov 2002 13:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265908AbSKBS32>; Sat, 2 Nov 2002 13:29:28 -0500
Received: from [207.88.206.43] ([207.88.206.43]:29315 "EHLO
	intruder-luxul.gurulabs.com") by vger.kernel.org with ESMTP
	id <S263517AbSKBS30>; Sat, 2 Nov 2002 13:29:26 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Dax Kelson <dax@gurulabs.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, davej@suse.de
In-Reply-To: <20021102070607.GB16100@think.thunk.org>
References: <20021101085148.E105A2C06A@lists.samba.org>
	<1036175565.2260.20.camel@mentor>  <20021102070607.GB16100@think.thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Nov 2002 11:35:56 -0700
Message-Id: <1036262156.31699.78.camel@thud>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 00:06, Theodore Ts'o wrote:
> On Fri, Nov 01, 2002 at 11:32:43AM -0700, Dax Kelson wrote:
> > 
> > On Fri, 2002-11-01 at 01:49, Rusty Russell wrote:
> > > I'm down to 8 undecided features: 6 removed and one I missed earlier.
> > 
> > How about Olaf Dietsche's filesystem capabilities support? It has been
> > posted a couple times to LK, yesterday even.
> 
> Ugh.  Personally, as I've said, I'm not convinced filesystem
> capabilities is worth it, providing the illusion of security --- and
> probably will make most systems more insecure because most system
> administrators won't be able to deal with fs capabilties competently.

I see this as a "vendor, RPM maintainer, developer" thing. The
developer,vendor,RPM mainter should be able to determine exactly what
capabilities an otherwise SUID root app needs and ship it appropriately.

Most sysadmin can't 'deal with X', where X is:

- Setup routing properly
- Configure kerberos
- Compile a kernel
- Use setfactl
- ext2/3 attributes
- IPTables
- SGID directories
- Apply a patch


That doesn't mean we should remove the above because they can be used
incorrectly/inappropriately and possibly damage and/or insecure a
system.

Dax

