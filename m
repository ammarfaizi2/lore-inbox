Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312372AbSDCTQO>; Wed, 3 Apr 2002 14:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312345AbSDCTQE>; Wed, 3 Apr 2002 14:16:04 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:48259
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S312348AbSDCTPv>; Wed, 3 Apr 2002 14:15:51 -0500
Date: Wed, 3 Apr 2002 12:15:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
Message-ID: <20020403191538.GA7211@opus.bloom.county>
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2002 at 09:41:55AM -0700, Eric W. Biederman wrote:

> In imitation of the arm and ppc ports a CONFIG_CMDLINE option is also
> implemented.

Just wondering, why didn't you do it with a
CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE set of options?  The way you did it,
I _think_ you can't actually get a help msg from 'config' or
'oldconfig', you'll just set the commandline to '?'.

Also, on current PPC, if we have a compiled-in commandline we put it in
arch/ppc/kernel/setup.c and allow it to be overridden.  This even makes
it semi-useful outside of the self-containted {b,}zImage situation.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
