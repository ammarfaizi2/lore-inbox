Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUDIGsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 02:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUDIGsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 02:48:18 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:10707 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261913AbUDIGsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 02:48:13 -0400
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Chris Meadors <clubneon@hereintown.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: initramfs howto?
References: <1081451826.238.23.camel@clubneon.priv.hereintown.net>
	<1081490209.28834.19.camel@camp4.serpentine.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 09 Apr 2004 15:48:05 +0900
In-Reply-To: <1081490209.28834.19.camel@camp4.serpentine.com>
Message-ID: <buo4qrt4pga.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@serpentine.com> writes:
> Ooh, I see that Olaf Hering has a recent variant of this patch which is
> in -aa kernels.  Andrew, can you consider dropping this into -mc or -mm,
> please?  It won't break normal operation, but will relieve the pain of
> the not-yet-battle-scarred.  It's less fugly than the earlier dev=0:0
> patch.  Maybe.
> 
> http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc3-aa1/initramfs-search-for-init

If you use that, can you just keep using the initial initramfs as your
root fs forever?  That'd be swell for embedded systems...

If so, it'd be nice if it checked for some other name than /init
(e.g. /sbin/init) -- there's too much crap in / already.

Thanks,

-Miles
-- 
I'd rather be consing.
