Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbQKLNbH>; Sun, 12 Nov 2000 08:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129723AbQKLNa5>; Sun, 12 Nov 2000 08:30:57 -0500
Received: from Cantor.suse.de ([194.112.123.193]:42507 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129281AbQKLNat>;
	Sun, 12 Nov 2000 08:30:49 -0500
Date: Sun, 12 Nov 2000 14:30:47 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ecki@lina.inka.de, linux-kernel@vger.kernel.org
Subject: Re: Missing ACKs with Linux 2.2/2.4?
Message-ID: <20001112143047.A9227@gruyere.muc.suse.de>
In-Reply-To: <E13ugIb-0004jA-00@calista.inka.de> <200011112227.OAA02548@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011112227.OAA02548@pizda.ninka.net>; from davem@redhat.com on Sat, Nov 11, 2000 at 02:27:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 02:27:13PM -0800, David S. Miller wrote:
>    From: Bernd Eckenfels <ecki@lina.inka.de>
>    Date: 	Sat, 11 Nov 2000 20:26:49 +0100
> 
>    Or is timestamp 0 a legal value?
> 
> It is legal.

NetBSD ignores 0 timestamps. Although that's a hack it is IMHO a reasonable one and 
Linux should probably do it too. Even when the 0 is generated legitimately by wrapping
counters it is probably not a big problem to lose timestamps for such few packets.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
