Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266848AbSKUR1O>; Thu, 21 Nov 2002 12:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbSKUR1O>; Thu, 21 Nov 2002 12:27:14 -0500
Received: from holomorphy.com ([66.224.33.161]:58753 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266848AbSKUR1O>;
	Thu, 21 Nov 2002 12:27:14 -0500
Date: Thu, 21 Nov 2002 09:26:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Bill Davidsen <davidsen@tmr.com>,
       Aaron Lehmann <aaronl@vitelus.com>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
Message-ID: <20021121172650.GR23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Bill Davidsen <davidsen@tmr.com>,
	Aaron Lehmann <aaronl@vitelus.com>,
	Con Kolivas <conman@kolivas.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <3DD0E037.1FC50147@digeo.com> <Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com> <3DDC1480.402A0E5B@digeo.com> <20021121000811.GQ23425@holomorphy.com> <3DDC8330.FE066815@digeo.com> <20021121132014.GC9883@suse.de> <3DDD162B.BAC88F94@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD162B.BAC88F94@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 09:21:47AM -0800, Andrew Morton wrote:
> We'd buy a bit by arranging for the in-kernel copy of the fp state
> to have the same layout as the hardware.  That way it can be done in
> a single big, fast, well-aligned slurp.  But for some reason that code has
> to convert into and out of a different representation.
> But the real low-hanging fruit here is the observation that the
> test application doesn't use floating point!!!
> Maybe we need to take an fp trap now and then to "poll" the application
> to see if it is still using float.

Um... both of these are in the "wtf?? it doesn't do that now??" category.


Bill
