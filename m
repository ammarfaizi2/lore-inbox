Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132565AbRAVQsU>; Mon, 22 Jan 2001 11:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbRAVQsL>; Mon, 22 Jan 2001 11:48:11 -0500
Received: from postfix.conectiva.com.br ([200.250.58.155]:9234 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132441AbRAVQrw>; Mon, 22 Jan 2001 11:47:52 -0500
Message-ID: <3A6C642E.2DF49CC0@conectiva.com.br>
Date: Mon, 22 Jan 2001 14:47:42 -0200
From: Andrew Clausen <clausen@conectiva.com.br>
Organization: Conectiva
X-Mailer: Mozilla 4.76 [pt_BR] (X11; U; Linux 2.2.17-14cl i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-fsdevel@vger.kernel.org, bug-parted@gnu.org,
        linux-kernel@vger.kernel.org
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <3A6C5D12.99704689@conectiva.com.br> <3A6C609F.F135DB0@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> For compatability with dual booting other operating systems.  Would you
> want Windows walking over your ext2 filesystems?  Linux didn't invent
> the partition table schemes, it just borrows from those that are most
> common for a given architecture (ie. msdos on PC compatable systems,
> etc.)

Of course, we need to be careful of this kind of stuff.  (That's the
only reason we have partition tables in the first place!)

But, for "well behaved operating systems", can't we do it this way?
(For the dos partition table scheme, 0x83 could be our "file system
type", 0x82 our "swap type", or whatever)

Tchau,
Andrew Clausen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
