Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVADCU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVADCU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 21:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVADCU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 21:20:56 -0500
Received: from dialin-212-144-120-172.arcor-ip.net ([212.144.120.172]:40712
	"EHLO spit.home") by vger.kernel.org with ESMTP id S261964AbVADCUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 21:20:46 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Diego Calleja <diegocg@teleline.es>
Subject: Re: starting with 2.7
Date: Tue, 4 Jan 2005 03:06:25 +0100
User-Agent: KMail/1.7.1
Cc: Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, bunk@stusta.de,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
References: <20050102221534.GG4183@stusta.de> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es>
In-Reply-To: <20050103142412.490239b8.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501040306.28221.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 03 January 2005 14:24, Diego Calleja wrote:

> I fully agree with WLI that the 2.4 development model and the
> backporting-mania created more problems than it solved, because in the real
> world almost everybody uses what distros ship, and what distros ship isn't
> kernel.org but heavily modified kernels, which means that the kernel.org
> was not really "well-tested" or it took much longer to become "well-tested"
> because it wasn't really being used.

Backporting isn't the primary problem. The real problem were the huge time 
intervals between stable releases. A new stable release brings a huge amount 
of changes which got different levels of testing, which makes upgrading quite 
an experience.
What we need are regular releases of stable kernels with a manageable amount 
of changes and a development tree to pull these changes from. It's a bit 
comparable to Debian testing/unstable. Changes go only from one tree to the 
other if they fulfil certain criteria. The job of the stable tree maintainer 
wouldn't be anymore to apply random patches sent to him, but to select 
instead which patches to pull from the development tree.
This doesn't of course guarantees perfectly stable kernels, but it would 
encourage more people to run recent stable kernels and avoids the huge steps 
in kernel upgrades. The only problem is that I don't know of any source code 
management system which supports this kind of development reasonably easy...

bye, Roman
