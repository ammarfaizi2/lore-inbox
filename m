Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWAIQZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWAIQZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWAIQZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:25:15 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:28548 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S964861AbWAIQZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:25:13 -0500
Date: Mon, 9 Jan 2006 18:25:07 +0200
From: Ville Herva <vherva@vianova.fi>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, gcoady@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060109162507.GZ21365@vianova.fi>
Reply-To: vherva@vianova.fi
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr> <20060105103339.GG20809@redhat.com> <20060108133822.GD31624@vianova.fi> <20060108055322.18d4236e.rdunlap@xenotime.net> <6cq2s1d3glnj56pcrqlj84s8ltilmo6jfp@4ax.com> <20060108174505.6c9b7566.rdunlap@xenotime.net> <Pine.LNX.4.61.0601091714330.26210@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601091714330.26210@yvahk01.tjqt.qr>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 05:15:55PM +0100, you [Jan Engelhardt] wrote:
> >> So would it be viable to take over the screen in similar fashion?
> >> 
> >> Set it to 80x50 in BIOS and dump there --> call it the Penguin Oops 
> >> screen, or Poops for short :o)
> >
> >It does take over the screen.  80x50 isn't needed since it knows how
> >to scroll the kernel log buffer on 80x25.
> 
> It's needed because scrolling back might be impossible (shift-up in panic 
> = no-go), not because it knows how to scroll.

Please try kmsgdump. 

It has its own real-mode terminal (with scrolling) to which it switches on
oops. Hung kernel console doesn't affect it.



-- v -- 

v@iki.fi

