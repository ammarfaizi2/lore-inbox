Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289328AbSA2OYm>; Tue, 29 Jan 2002 09:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSA2OYe>; Tue, 29 Jan 2002 09:24:34 -0500
Received: from pc-80-195-34-66-ed.blueyonder.co.uk ([80.195.34.66]:11393 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S289353AbSA2OYX>; Tue, 29 Jan 2002 09:24:23 -0500
Date: Tue, 29 Jan 2002 14:24:00 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: Assertion failure / do_get_write_acess() / loop / samba
Message-ID: <20020129142400.E1873@redhat.com>
In-Reply-To: <008f01c1a815$d8cdcc70$8a140237@rennes.si.fr.atosorigin.com> <20020129114222.B2298@redhat.com> <02c801c1a8cd$027ccd20$8a140237@rennes.si.fr.atosorigin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02c801c1a8cd$027ccd20$8a140237@rennes.si.fr.atosorigin.com>; from yann.morin.1998@anciens.enib.fr on Tue, Jan 29, 2002 at 02:58:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 29, 2002 at 02:58:20PM +0100, Yann E. MORIN wrote:

> > Are there any other log messages in the kernel log?
> 
> No. This is the only one. Even when I enter 'reboot' and hit enter, it
> just freezes without any message. For quite a while (more than 5').
> Nothing more appears, niether on screen nor on my serial console.

Did you try a "dmesg"?

> That I tested. No bad block on the remote host (assertion happens
> only when writing to a loop residing on a samba share, on a Win2k
> host).

OK, that's certainly something I can try to reproduce --- ext3 over
loop over smbfs is not something which gets tested every day by the
ext3 developers. :-)

Cheers,
 Stephen
