Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUARHZO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 02:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUARHZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 02:25:14 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:13463 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265816AbUARHZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 02:25:10 -0500
Date: Sun, 18 Jan 2004 08:24:36 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Romain Lievin <romain@rlievin.dyndns.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] "gconfig" removed root folder...
Message-ID: <20040118072435.GA9017@louise.pinerecords.com>
References: <1074177405.3131.10.camel@oebilgen> <20040115214416.GA25409@rlievin.dyndns.org> <20040116161440.GC30349@louise.pinerecords.com> <20040117214756.GA30465@rlievin.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117214756.GA30465@rlievin.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan-17 2004, Sat, 22:47 +0100
Romain Lievin <romain@rlievin.dyndns.org> wrote:

> > On Jan-15 2004, Thu, 22:44 +0100
> > Romain Lievin <romain@rlievin.dyndns.org> wrote:
> > 
> > > +	if(stat(fn, &sb) == -1) return;	
> > 
> > Codingstyle inconsistency.
> 
> What should I write then ? Your piece of advice may make me better.

Read Documentation/CodingStyle.  It is loosely based on the original
K&R style, where (the scarce) language constructs' arguments' opening
parenthese is prepended by a space, whereas with functions and macros
it is not.  I.e., one writes 'if (...)', 'while (...)', 'foo(bar)', etc.

Also, your explicit casts could use extra whitespace, like so:
"a = (int *) b;" not "a = (int *)b;"

When submiting code to an existing file, the general rule of thumb
is not to disrupt the style of that particular file, regardless
of what it appears to be.  You have managed to break this rule
_and_ the official CodingStyle.

-- 
Tomas Szepe <szepe@pinerecords.com>
