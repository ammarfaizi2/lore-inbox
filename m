Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267587AbUG3EJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUG3EJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 00:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267592AbUG3EJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 00:09:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12221 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267587AbUG3EJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 00:09:56 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       suparna@in.ibm.com, fastboot@osdl.org, mbligh@aracnet.com,
       jbarnes@engr.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <E1BqJQF-00053v-00@w-gerrit2>
	<m1zn5i2weh.fsf@ebiederm.dsl.xmission.com>
	<1091143551.1596.17.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Jul 2004 22:07:35 -0600
In-Reply-To: <1091143551.1596.17.camel@localhost.localdomain>
Message-ID: <m1r7qu2l4o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Gwe, 2004-07-30 at 01:04, Eric W. Biederman wrote:
> > The beauty of kexec is all of these fun things become user 
> > problems from the point of the view of the sick kernel so
> > it does not need to worry about them.
> > 
> > I will be happy to see a SHA patch for /sbin/kexec.  
> 
> crypto/sha1.c provides all the code you need.

Yep that is the easy part, finding a sha1 implementation.  The
interesting part is the logic that hooks in the code and computes and
checks the hash.  Especially with the area the sha1 code checkes
including the sha1 check code :)

Eric
