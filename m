Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbQJZVQT>; Thu, 26 Oct 2000 17:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129814AbQJZVQI>; Thu, 26 Oct 2000 17:16:08 -0400
Received: from styx.suse.cz ([195.70.145.226]:34555 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129851AbQJZVQF>;
	Thu, 26 Oct 2000 17:16:05 -0400
Date: Thu, 26 Oct 2000 23:15:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
Message-ID: <20001026231530.A883@suse.cz>
In-Reply-To: <20001026190309.A372@suse.cz> <Pine.LNX.3.95.1001026134131.13342A-100000@chaos.analogic.com> <20001026200220.A492@suse.cz> <878zrbl5v9.fsf@alph.dyndns.org> <20001026221640.A703@suse.cz> <873dhjl3en.fsf@alph.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <873dhjl3en.fsf@alph.dyndns.org>; from yoann@mandrakesoft.com on Thu, Oct 26, 2000 at 11:05:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 11:05:04PM +0200, Yoann Vandoorselaere wrote:

> yop, I 've done :
> 
> make -j10 World 
> in the xfree tree and simulateously :
> 
> while true; do make dep && make clean && make bzImage; done
> in the kernel tree

Now it'd be nice to verify that the problem also happens when the system
is not running out of memory (which -j10 quite causes I think) ...

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
