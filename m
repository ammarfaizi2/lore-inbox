Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262328AbTCRKlc>; Tue, 18 Mar 2003 05:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262329AbTCRKlc>; Tue, 18 Mar 2003 05:41:32 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:65153 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262328AbTCRKlb>; Tue, 18 Mar 2003 05:41:31 -0500
Subject: Re: 2.5.64-mm8 breaks MASQ
From: Shawn <core@enodev.com>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
In-Reply-To: <1047922184.3223.2.camel@iso-8590-lx.zeusinc.com>
References: <1047922184.3223.2.camel@iso-8590-lx.zeusinc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047984726.3914.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Mar 2003 04:52:06 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This actually broke in -mm7, but I don't know what causes it.

I have to admit, I haven't even looked at the patch to see what changed.
Oh well, I suspect good ol' 65-mm1 will fix things up. If so, my TiVo
could stop holding it's breath. ;)

Anyone else seeing this?

On Mon, 2003-03-17 at 11:29, Tom Sightler wrote:
> I have been attempting to test the -mm kernels.  I was having problems
> with the anticipatory scheduler up causing the machine to hang during
> loading of the USB driver.  The recent fixes that went into -mm8 seem to
> have corrected this problem, unfortunately I'm now hitting another
> issue.
> 
> It seems that -mm8 breaks MASQ support in iptables.  Actually I can't
> get any MASQ/NAT to work at all.  The same exact config works fine with
> vanilla 2.5.64 and 2.5.64-ac4.
> 
> Backing out the brlock patches returns everything to normal operation so
> there's something happening with those.  I'll try to look at them
> individually if I get a chance but I know practically nothing about that
> code so somebody will probably spot a problem quicker.
> 
> Later,
> Tom
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
