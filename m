Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131828AbQKDJE4>; Sat, 4 Nov 2000 04:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132635AbQKDJEq>; Sat, 4 Nov 2000 04:04:46 -0500
Received: from Cantor.suse.de ([194.112.123.193]:5139 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131828AbQKDJEj>;
	Sat, 4 Nov 2000 04:04:39 -0500
Date: Sat, 4 Nov 2000 10:04:16 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andi Kleen <ak@suse.de>, Bill Wendling <wendling@ganymede.isdn.uiuc.edu>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        davies@maniac.ultranet.com
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
Message-ID: <20001104100416.A10972@gruyere.muc.suse.de>
In-Reply-To: <20001103202911.A2979@gruyere.muc.suse.de> <200011031937.WAA10753@ms2.inr.ac.ru> <20001103160108.D16644@ganymede.isdn.uiuc.edu> <3A033C82.114016A0@mandrakesoft.com> <20001104004129.C5173@gruyere.muc.suse.de> <3A0350EC.8B1A3B4D@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A0350EC.8B1A3B4D@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Nov 03, 2000 at 06:57:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 06:57:32PM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> > de4x5 is stable, but tends to perform badly under load, mostly because
> > it doesn't use rx_copybreak and overflows standard socket buffers with its
> > always MTU sized skbuffs.
> 
> One of the reasons that de4x5 isn't gone already is that I get reports
> that de4x5 performs better than the tulip driver for their card.

I have the same reports from various sources (but then they complain
about the socket buffer issue ;)  I think it would be best
to just keep it as it is with minimal mainteance, even in 2.5.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
