Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319090AbSH2Du3>; Wed, 28 Aug 2002 23:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319091AbSH2Du3>; Wed, 28 Aug 2002 23:50:29 -0400
Received: from holomorphy.com ([66.224.33.161]:41345 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319090AbSH2Du3>;
	Wed, 28 Aug 2002 23:50:29 -0400
Date: Wed, 28 Aug 2002 20:54:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       pavel@elf.ucw.cz, andrea <andrea@suse.de>,
       Mikael Pettersson <mikpe@csd.uu.se>, msw@redhat.com,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [FTF][PATCH] linux-2.4.20-pre5_bad-tsc_A0
Message-ID: <20020829035437.GE888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, pavel@elf.ucw.cz,
	andrea <andrea@suse.de>, Mikael Pettersson <mikpe@csd.uu.se>,
	msw@redhat.com, Ulrich Drepper <drepper@redhat.com>
References: <1030584008.3056.53.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1030584008.3056.53.camel@cog>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 06:20:07PM -0700, john stultz wrote:
> As long as folks still seem interested in this, I'll keep on maintaining
> it, but if you feel it should just die, let me know.

Is there any chance you could do a 2.5.32 version that skips over
synchronize_tsc_ap() etc. entirely? synchronize_tsc_ap() appears to
oops on 32x NUMA-Q boxen (though it could be io_apic.c running amok).


Cheers,
Bill
