Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbTLHAuh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 19:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTLHAug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 19:50:36 -0500
Received: from ppp-168-253-10-94.den1.ip.ricochet.net ([168.253.10.94]:15620
	"EHLO mercury.illtel.denver.co.us") by vger.kernel.org with ESMTP
	id S264796AbTLHAu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 19:50:27 -0500
Date: Sun, 7 Dec 2003 18:00:08 -0700 (MST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Additional clauses to GPL in network drivers
In-Reply-To: <200312071515.hB7FFkQH000866@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.58.0312071753230.1236@mercury>
References: <200312071515.hB7FFkQH000866@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Dec 2003, John Bradford wrote:

> For example, it brings up a few issues:
>
> 1. How is 'operating system' supposed to be defined in this context?
>
> I assume that if it meant just the kernel, it would say 'kernel'.
>
> If you define 'operating system' as including some userspace
> utilities, it's going to cause problems, as some common utilities are
> not GPL'ed, (the extra clause doesn't say 'GPL-compatible', it
> specifically specifies GPL).

  I guess, it really means, "kernel as distributed".

> 2. Is code licensed under this extra term actually compatible with
> code placed under the GPL alone?

  As I understand it, the statement was only meant to emphasize that the
file is a part of a larger work that is licensed under GPL, and its (and
derivations') distribution as a separate work is still governed by GPL
(in particular, it does not allow incorporation into other products under
other licenses) and the authors are unwilling to re-license it under any
non-GPL terms. The way how it was expressed is unclear and formally
incorrect, but I think, the intent of the statement is merely to re-state
the restrictions that are already in GPL and discourage attempts to obtain
(or assume) other licenses.

> 3. I haven't tried to trace the history of this code, but if these
> drivers were based on, and include, other developer's purely GPL'ed
> code, applying this extra condition is presumably not valid, (unless
> specific permission was sought to do so).
>
> 4. The obvious issue concerning binary modules - does loading a binary
> module which is not licensed under the GPL invalidate your license to
> use these network drivers?  Note that I personally have no interest
> whatsoever in using such binary modules, but whatever ends up being
> decided for the GPL'ed parts of the kernel, this extra clause suggests
> to me that it specifically isn't OK whilst using these network
> drivers.

  The statement is unclear on this, however if you read "operating system"
as "kernel as distributed" and "use" as "distribute" it would make perfect
sense. Otherwise it's meaningless.

-- 
Alex
