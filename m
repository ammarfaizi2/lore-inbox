Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVDESdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVDESdT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVDESch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:32:37 -0400
Received: from colin2.muc.de ([193.149.48.15]:9225 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261861AbVDESbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:31:42 -0400
Date: 5 Apr 2005 20:31:41 +0200
Date: Tue, 5 Apr 2005 20:31:41 +0200
From: Andi Kleen <ak@muc.de>
To: Christopher Allen Wing <wingc@engin.umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
Message-ID: <20050405183141.GA27195@muc.de>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se> <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> <m18y3x16rj.fsf@muc.de> <Pine.LNX.4.58.0504051351200.13242@hammer.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504051351200.13242@hammer.engin.umich.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 02:02:20PM -0400, Christopher Allen Wing wrote:
> 
> Are you thinking of blacklisting the APIC on this system until we figure
> out what's going on?

Some more debugging first might be good. Perhaps it is the same issue
many Nvidia boards have with the APIC timer override being wrong;
although in this case it should more not tick at all, but might
be still worth a try.
Try booting with acpi_skip_timer_override

-Andi
