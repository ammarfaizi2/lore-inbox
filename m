Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289473AbSA3Q16>; Wed, 30 Jan 2002 11:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290032AbSA3Q1D>; Wed, 30 Jan 2002 11:27:03 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46292 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290010AbSA3QZq>;
	Wed, 30 Jan 2002 11:25:46 -0500
Date: Wed, 30 Jan 2002 11:25:44 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: "'Chris Ricker'" <kaboom@gatech.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: ANOTHER modest proposal -- We need a documentation package
Message-ID: <20020130112544.B21325@havoc.gtf.org>
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2B2B@ottonexc1.ottawa.loran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2B2B@ottonexc1.ottawa.loran.com>; from dana.lacoste@peregrine.com on Wed, Jan 30, 2002 at 07:03:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 07:03:05AM -0800, Dana Lacoste wrote:
> Take linux/Documentation and split it into a separate package.
> that way Linus doesn't need to care about documentation, it can
> be maintained separately.  Having documentation packages co-released
> with the kernel, but separately maintained would fix this problem,
> would it not?

Alas this would simply make it more difficult for me to update things.
For example I update Documentation/networking/8139too.txt each time
there is a corresponding update to drivers/net/8139too.c.  Having to go
from current situation to patching two totally separate trees would be a
PITA and regression from current workflow.

	Jeff



