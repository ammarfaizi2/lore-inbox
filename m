Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129293AbQJZVZA>; Thu, 26 Oct 2000 17:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129225AbQJZVYv>; Thu, 26 Oct 2000 17:24:51 -0400
Received: from r109m245.cybercable.tm.fr ([195.132.109.245]:28676 "HELO
	alph.dyndns.org") by vger.kernel.org with SMTP id <S129213AbQJZVYk>;
	Thu, 26 Oct 2000 17:24:40 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
In-Reply-To: <20001026190309.A372@suse.cz>
	<Pine.LNX.3.95.1001026134131.13342A-100000@chaos.analogic.com>
	<20001026200220.A492@suse.cz> <878zrbl5v9.fsf@alph.dyndns.org>
	<20001026221640.A703@suse.cz> <873dhjl3en.fsf@alph.dyndns.org>
	<20001026231530.A883@suse.cz>
From: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Date: 26 Oct 2000 23:24:38 +0200
In-Reply-To: Vojtech Pavlik's message of "Thu, 26 Oct 2000 23:15:30 +0200"
Message-ID: <87r953jnxl.fsf@alph.dyndns.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Thu, Oct 26, 2000 at 11:05:04PM +0200, Yoann Vandoorselaere wrote:
> 
> > yop, I 've done :
> > 
> > make -j10 World 
> > in the xfree tree and simulateously :
> > 
> > while true; do make dep && make clean && make bzImage; done
> > in the kernel tree
> 
> Now it'd be nice to verify that the problem also happens when the system
> is not running out of memory (which -j10 quite causes I think) ...

Nope, my system was loaded, but was usable
(at least until the problem occured)...

Athlon 750 with 128mb of ram and 103mb of swap.

-- 
		-- Yoann http://www.mandrakesoft.com/~yoann/
   An engineer from NVidia, while asking him to release cards specs said :
	"Actually, we do write our drivers without documentation."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
