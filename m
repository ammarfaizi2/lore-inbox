Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWGQP4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWGQP4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWGQP4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:56:13 -0400
Received: from mail.gmx.net ([213.165.64.21]:33441 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750826AbWGQP4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:56:12 -0400
X-Authenticated: #428038
Date: Mon, 17 Jul 2006 17:56:10 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Jeff Anderson-Lee <jonah@eecs.berkeley.edu>
Cc: "'fsdevel'" <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
Message-ID: <20060717155610.GE8276@merlin.emma.line.org>
Mail-Followup-To: Jeff Anderson-Lee <jonah@eecs.berkeley.edu>,
	'fsdevel' <linux-fsdevel@vger.kernel.org>,
	linux-kernel@vger.kernel.org
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <000001c6a9b3$81186ea0$ce2a2080@eecs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001c6a9b3$81186ea0$ce2a2080@eecs.berkeley.edu>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2006, Jeff Anderson-Lee wrote:

> I saw a log-structured file system being developed as a Google summer
> project recently.  It's likely doomed to obscurity by the fs-related
> code-churning in the Linux kernel.  Since it is "experimental" it won't be
> included in the kernel distribution and hence won't get the benefit of
> kernel developers making sweeping changes that touch all the file system
> dependent code.  You practically need it to be your full-time job in order
> to do any research or development work under Linux with this kind of
> environment.

> 2) A lessening (moratorium?) on sweeping changes for a while, so that FS
> developers would have a chance to try new ideas without being flooded with
> changes needed just to keep up with the latest kernel, or

Other suggestions:

- try it on 2.6.16.X which is supposed to be longer-lived, and forward
  port as that system is discontinued.

- see if you can implement your concepts in user space (FUSE). If there
  are sufficient advantages, port it to the kernel.

> Of these: (1) is likely impractical, as it imposes an additional burden on
> kernel developers to support obscure or experimental f/s.  (2) is only a
> stop-gap, as at some point sweeping changes might again be made that would
> out-date most experimental f/s.  (3) seems the most logical course: work
> towards a better interface between the FS dependent and independent layers
> (e.g. VFS, mm) that does a better job of isolating the layers from each
> other.

Linux developers have often uttered their unwillingness for stable
interfaces.

> Without that, *BSD (and now possibly OpenSolaris) will be preferred over
> Linux for FS research, which typically means that few if any people benefit
> from the results: a loss for both Linux and the community at large.

If the file system is so crucial for the intended application, would not
its choice alone dominate over all other criteria and demote the weight
of the OS rather "convenience" or "it's just a name"?

-- 
Matthias Andree
