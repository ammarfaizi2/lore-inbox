Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312748AbSDBDOd>; Mon, 1 Apr 2002 22:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312752AbSDBDOX>; Mon, 1 Apr 2002 22:14:23 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:45729 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S312748AbSDBDOL>; Mon, 1 Apr 2002 22:14:11 -0500
Date: Mon, 1 Apr 2002 21:14:10 -0600
From: Ken Brownfield <ken@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: Status of quotas on ext3 and reiser?
Message-ID: <20020401211410.A9161@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm about to install a 2TB disk array, and I'd very strongly prefer to
use ext3 or possibly reiser to gain journaling.  Fscking 250GB is
already lethal.

But I also need quotas.  I've noticed that quotas do not appear to be
supported by ext3, but I haven't tried reiser yet.  And I'm not sure
if I simply need new quota userspace tools -- the ones I found were 1994
vintage.  I'm on RH6.2 BTW for this case, and the builtin tools don't
appear to grok ext3.

What is the current viability of quotas on ext3/reiser in a
conservative, production environment?  Is it waiting for the 32-bit UID
mods in 2.4.x, or has quota support been pushed off onto 2.5?  Am I
going to have to make the hard choice of journaling vs quotas? :-/

I couldn't find a definitive answer in the archives; sorry if this is a
FAQ.  I'd bug poor Andrew Morton directly :), but I'm also interested in
the status or reiser vs quotas.

Thanks,
-- 
Ken.
ken@irridia.com
