Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTE0MwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTE0MwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:52:12 -0400
Received: from holomorphy.com ([66.224.33.161]:24544 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263572AbTE0MwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:52:10 -0400
Date: Tue, 27 May 2003 06:05:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <20030527130515.GH8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	DevilKin <devilkin-lkml@blindguardian.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305271048.36495.devilkin-lkml@blindguardian.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 10:48:29AM +0200, DevilKin wrote:
> include/linux/mmzone.h:18:1: warning: this is the location of the previous 
> definition
> arch/i386/kernel/numaq.c: In function `initialize_physnode_map':
> arch/i386/kernel/numaq.c:95: error: `physnode_map' undeclared (first use in 
> this  function)
> arch/i386/kernel/numaq.c:95: error: (Each undeclared identifier is reported 
> only  once
> arch/i386/kernel/numaq.c:95: error: for each function it appears in.)
> make[2]: *** [arch/i386/kernel/numaq.o] Error 1
> make[1]: *** [arch/i386/kernel] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.70'
> make: *** [stamp-build] Error 2

I suspect you're attempting to shoot yourself in the foot. .config?


-- wli
