Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129329AbRBKNrA>; Sun, 11 Feb 2001 08:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129332AbRBKNqu>; Sun, 11 Feb 2001 08:46:50 -0500
Received: from CPE-61-9-148-50.vic.bigpond.net.au ([61.9.148.50]:7808 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S129329AbRBKNqf>; Sun, 11 Feb 2001 08:46:35 -0500
Date: Mon, 12 Feb 2001 00:57:48 +1100
From: john slee <indigoid@higherplane.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hard lockup (no oops) on vanilla 2.4.2-pre3 with /dev/dsp
Message-ID: <20010212005748.A1171@higherplane.net>
In-Reply-To: <20010211053145.A748@higherplane.net> <E14RfmM-0002Ao-00@the-village.bc.nu> <20010211131902.A1003@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010211131902.A1003@higherplane.net>; from indigoid@higherplane.net on Sun, Feb 11, 2001 at 01:19:02PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 01:19:02PM +1100, john slee wrote:
> On Sat, Feb 10, 2001 at 07:33:53PM +0000, Alan Cox wrote:
> > Does 2.4.1-ac9 behave ?
> 
> yep, works fine.

let me amend this slightly:  works fine when not using xfree86 with pci
s3virge.  guess it wasnt the kernel at fault after all.  :-)  2.4.2-pre3
behaves also, haven't bothered trying anything else yet.  note that
commenting out the bits of XF86Config relevant to the s3 was sufficient,
didn't need to physically remove the card.

it is still odd, since there aren't any resource conflicts (that i am
aware of)

thanks,

j.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
