Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTE0Roo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTE0Rnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:43:45 -0400
Received: from holomorphy.com ([66.224.33.161]:34536 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264024AbTE0RnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:43:02 -0400
Date: Tue, 27 May 2003 10:56:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Stoffel <stoffel@lucent.com>
Cc: DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <20030527175604.GN8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Stoffel <stoffel@lucent.com>,
	DevilKin-LKML <devilkin-lkml@blindguardian.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL> <20030527155259.GK8978@holomorphy.com> <16083.37850.528654.94908@gargle.gargle.HOWL> <20030527164300.GL8978@holomorphy.com> <16083.42349.964658.11555@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16083.42349.964658.11555@gargle.gargle.HOWL>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"William" == William Lee Irwin <wli@holomorphy.com> writes:
William> CONFIG_NR_CPUS should appear under the processor type and
William> features menu.

On Tue, May 27, 2003 at 01:50:37PM -0400, John Stoffel wrote:
> I must not have been clear enough in my rant, so let me rephrase it.  
> Because I had already configured NR_CPUS=2, I'm not sure that I should
> have even gotten the choice of X86_BIGSMP at all, since it's obviously
> not valid in this case.
> I'm really asking for the configuration specifications and
> dependencies to be cleaned up, and maybe I'll try to do it myself and
> send in the patch.  Right now I'm going to be trying 2.5.70-mm1 with a
> patch for my ISA Cyclades board first.

They're meant to specify system types, in particular APIC configurations.


On Tue, May 27, 2003 at 01:50:37PM -0400, John Stoffel wrote:
> So the real thrust of my posts before was:
> The language and description used when running 'make oldconfig' and
> trying to set the "X86_GENERICARCH" option is ugly and hard to
> understand and doesn't match how it's shown in the 'make menuconfig'
> settings.  
> Sure, I realize that oldconfig is more a helper than a real
> interface, but it still has warts that I'd like to fix or have
> someone else fix if I can't do it myself.
> Maybe the entire issue is really how do you do specify and constrain
> inputs properly in this setup?

No idea. Ask Roman Zippel.

My expectation is that we aren't going to make kernel configuration
safe for Aunt Tillie anytime in the near future.


-- wli
