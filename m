Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRCCVeV>; Sat, 3 Mar 2001 16:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129762AbRCCVeL>; Sat, 3 Mar 2001 16:34:11 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:46066 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129759AbRCCVd6>; Sat, 3 Mar 2001 16:33:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] 2.4.x system Freezes
Date: Sat, 3 Mar 2001 16:31:29 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <E14YzmE-0002dD-00@the-village.bc.nu>
In-Reply-To: <E14YzmE-0002dD-00@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01030316312900.00689@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 March 2001 19:20, you wrote:
> > Should an X crash really freeze my box like a block of ice?  Would be
> > nice if linux could just detect an X crash an recover...  Is this too
> > much to ask from PC harware?
>
> X pokes hardware, so X is kind of a device driver in part. One slip and
> splat..

Yes - gather this can make life in the fast lane easier... if its all done 
perfectly.

Just wanted to confirm that the freezes _do_ happen with X3.3.6 too.  I was 
able to get into kdb from a serial console (an then lost the log - murphy can 
be a real PITA).   I figure a ps, bt and bta should be enough to point out 
the problem task?  Its there anything else I should do (sr t maybe?)?

This was with 2.4.2+ac10+kdb1.8 and x3.3.6 it froze when I returned to the 
keyboard after a pause of three hours.

TIA,
Ed
