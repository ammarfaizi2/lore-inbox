Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbRG2Bxc>; Sat, 28 Jul 2001 21:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbRG2BxW>; Sat, 28 Jul 2001 21:53:22 -0400
Received: from weta.f00f.org ([203.167.249.89]:9094 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267449AbRG2BxN>;
	Sat, 28 Jul 2001 21:53:13 -0400
Date: Sun, 29 Jul 2001 13:53:48 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>, linux-kernel@vger.kernel.org,
        Chris Mason <mason@suse.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010729135348.A3282@weta.f00f.org>
In-Reply-To: <E15QZNB-00082q-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15QZNB-00082q-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 28, 2001 at 08:03:37PM +0100, Alan Cox wrote:

    Ext3 I believe so, Reiserfs I would assume so but Hans can answer
    definitively

Reiserfs does not, nor are creates or unlink operations synchronous.

For MTAs it just happens to work: if you fsync the way transactions
are written means the metadata for the dirtectories is written as part
of the transaction --- but I think this is a quirk and not by design?

Chris?




  --cw
