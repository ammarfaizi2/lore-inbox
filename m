Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUCGQFp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbUCGQFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:05:45 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:29001 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262170AbUCGQFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:05:24 -0500
Date: Sun, 7 Mar 2004 17:05:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
Subject: Re: External kernel modules, second try
Message-ID: <20040307160527.GA2027@mars.ravnborg.org>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Andreas Gruenbacher <agruen@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>,
	"kbuild-devel@lists.sourceforge.net" <kbuild-devel@lists.sourceforge.net>
References: <1078620297.3156.139.camel@nb.suse.de> <20040307125348.GA2020@mars.ravnborg.org> <1078664629.9812.1.camel@laptop.fenrus.com> <1078667199.3594.50.camel@nb.suse.de> <1078668091.9106.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078668091.9106.1.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 03:01:31PM +0100, Arjan van de Ven wrote:
> >  and it's missing the symbols from
> > module files.
> 
> sure but the module files are generally installed...
I'm aiming for a situation where I can build external modules,
using an almost clean kernel src tree.

Which means that my "make clean on steroids" patch maybe is a bit
too effective.
The distintion point could be:

make clean leaves only enough to build external modules.
Otherwise we need a third (fourth) cleaning target, which is not desireable.


	Sam
