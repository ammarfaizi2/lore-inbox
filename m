Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUDAPzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUDAPzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:55:05 -0500
Received: from mail.shareable.org ([81.29.64.88]:9877 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262927AbUDAPzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:55:02 -0500
Date: Thu, 1 Apr 2004 16:54:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Peter Williams <peterw@aurema.com>,
       arjanv@redhat.com, ak@muc.de, Richard.Curnow@superh.com, aeb@cwi.nl,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040401155420.GB25502@mail.shareable.org>
References: <1079453698.2255.661.camel@cube> <20040320095627.GC2803@devserv.devel.redhat.com> <1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com> <20040331134009.76ca3b6d.rddunlap@osdl.org> <1080776817.2233.2326.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080776817.2233.2326.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> If you rely on sysconf(_SC_CLK_TCK) to work, then
> your software will support:
> 
> * all systems with a 2.6.xx kernel
> * all systems with a 2.4.xx kernel and recent glibc
> * all i386 systems running with the default HZ
> 
> That's quite a bit I suppose. Maybe you have no
> interest in supporting a 1200 HZ Alpha with an old
> kernel or glibc. Maybe you don't care about somebody
> running a 2.2.xx kernel with modified HZ.

I'm still unclear.  Does sysconf(_SC_CLK_TCK), when it is reliable,
return HZ or USER_HZ?

-- Jamie
