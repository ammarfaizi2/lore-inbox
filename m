Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbTLCNd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 08:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTLCNd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 08:33:28 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:56801 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264578AbTLCNdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 08:33:25 -0500
Date: Wed, 3 Dec 2003 14:33:18 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Johannes Stezenbach <js@convergence.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 ioctl compile warnings in userspace
Message-ID: <20031203133318.GD1947@wohnheim.fh-wedel.de>
References: <20031112163750.GB18989@convergence.de> <20031202114350.GA25170@iliana> <20031203125648.GC1947@wohnheim.fh-wedel.de> <20031203130603.GA7094@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031203130603.GA7094@iliana>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 December 2003 14:06:03 +0100, Sven Luther wrote:
> On Wed, Dec 03, 2003 at 01:56:48PM +0100, Jörn Engel wrote:
> > 
> > It doesn't clearly fix a bug, afaics.  Also, most kernel hackers don't
> > care too much about the signed/unsigned warnings, as they are 99%
> > noise.
> 
> Well, the main problem is that since the 2.6.0 kernel headers are used
> by glibc on debian (and maybe others) it makes building userland
> packages about this difficult. I was asking to know if there was
> something inherently bad about implementing this in the userland kernel
> headers provided by the glibc, as the glibc debian maintainers have not
> been responsive about this, but i know since that a fixed package will
> be provided once the situation resulting from the intrusion is cleared.

The current status for userland kernel headers is "the kernel doesn't
care".  Let the glibc folks and whoever else gather the information
from the kernel headers and create derived, but different, userland
headers.

So unless you change this paradigm, your point is void, sorry.

> > Resend the patch after 2.6.0 has been released, I don't see any change
> > for it to go in before.
> 
> But also no particular reason not to use it, right ?

Stability, stability, stability - are three reasons enough? ;)

Linus wants to have very few patches these days and all of them have
to fix a real bug.  Please don't question him doing so, just remember
the 2.4 days with slashdot stories like "kernel of pain".

Jörn

-- 
Fools ignore complexity.  Pragmatists suffer it.
Some can avoid it.  Geniuses remove it.
-- Perlis's Programming Proverb #58, SIGPLAN Notices, Sept.  1982
