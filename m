Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUENSIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUENSIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUENSIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:08:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:17356 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262020AbUENSH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:07:59 -0400
Date: Fri, 14 May 2004 11:07:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@stanford.edu>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Andy Lutomirski <luto@myrealbox.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, olaf+list.linux-kernel@olafdietsche.de,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] capabilites, take 2
Message-ID: <20040514110752.U21045@build.pdx.osdl.net>
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <fa.mu5rj3d.24gtbp@ifi.uio.no> <40A4EC72.2020209@myrealbox.com> <1084550518.17741.134.camel@moss-spartans.epoch.ncsc.mil> <40A4F163.6090802@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40A4F163.6090802@stanford.edu>; from luto@stanford.edu on Fri, May 14, 2004 at 09:18:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@stanford.edu) wrote:
> Stephen Smalley wrote:
> > On Fri, 2004-05-14 at 11:57, Andy Lutomirski wrote:
> > > Thanks -- turning brain back on, SELinux is obviously better than any
> > > fine-grained capability scheme I can imagine.
> > > 
> > > So unless anyone convinces me you're wrong, I'll stick with just
> > > fixing up capabilities to work without making them finer-grained.
> > 
> > Great, thanks.  Fixing capabilities to work is definitely useful and
> > desirable.  Significantly expanding them in any manner is a poor use of
> > limited resources, IMHO; I'd much rather see people work on applying
> > SELinux to the problem and solving it more effectively for the future.
> 
> Does this mean I should trash my 'maximum' mask?
> 
> (I like 'cap -c = sftp-server' so it can't try to run setuid/fP apps.)
> OTOH, since SELinux accomplishes this better, it may not be worth the
> effort.

Let's just get back to the simplest task.  Allow execve() to do smth.
reasonable with capabilities.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
