Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUG2Ngi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUG2Ngi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 09:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUG2Ngh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 09:36:37 -0400
Received: from users.linvision.com ([62.58.92.114]:58009 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264677AbUG2NgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 09:36:19 -0400
Date: Thu, 29 Jul 2004 15:36:17 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: 2.4.26 doesn't boot on a 386 without "Unsynced TSC support"
Message-ID: <20040729133617.GG1395@harddisk-recovery.com>
References: <200407281908.i6SJ8c9I015801@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407281908.i6SJ8c9I015801@harpo.it.uu.se>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 09:08:38PM +0200, Mikael Pettersson wrote:
> On Wed, 28 Jul 2004 17:47:49 +0200, Erik Mouw wrote:
> >My question is: is this a code bug, or a documentation bug? Right now,
> >I guess 2.4.26 will not run on anything < Pentium without
> >CONFIG_X86_TSC_DISABLE enabled.
> 
> It's a limitation in scripts/Configure.
> If you start with a .config with TSC enabled/required,
> and just flip the CPU selection option to a TSC-less
> CPU, like 386 or 486, then you end up with a .config
> that _still_ has TSC enabled/required.

I was indeed starting from a "known good" .config for an Athlon.

> The workaround is to run 'make oldconfig' afterwards.

That did the trick.


Thanks for the explanation,

Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
