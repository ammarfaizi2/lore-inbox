Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbTCLHlo>; Wed, 12 Mar 2003 02:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbTCLHlo>; Wed, 12 Mar 2003 02:41:44 -0500
Received: from are.twiddle.net ([64.81.246.98]:15794 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S263077AbTCLHln>;
	Wed, 12 Mar 2003 02:41:43 -0500
Date: Tue, 11 Mar 2003 23:52:23 -0800
From: Richard Henderson <rth@twiddle.net>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Message-ID: <20030311235223.A30856@twiddle.net>
Mail-Followup-To: Szakacsits Szabolcs <szaka@sienet.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <b4lvk2$vcd$1@cesium.transmeta.com> <Pine.LNX.4.30.0303120622290.15538-100000@divine.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.30.0303120622290.15538-100000@divine.city.tvnet.hu>; from szaka@sienet.hu on Wed, Mar 12, 2003 at 07:07:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 07:07:26AM +0100, Szakacsits Szabolcs wrote:
> Only way I see is to detect it at build time, BIG warning to the user
> of compiler, print a well visible "kernel was built by broken tools"
> message at boot time to end users ...

You don't have to let things go that far.  If you have a test
case, then you can run the test case at build time, and have
the make actively fail.  So the kernel never gets built at all.


r~
