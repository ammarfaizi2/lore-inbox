Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbRDCRx7>; Tue, 3 Apr 2001 13:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbRDCRxt>; Tue, 3 Apr 2001 13:53:49 -0400
Received: from ghost.btnet.cz ([62.80.85.74]:50443 "HELO ghost.btnet.cz")
	by vger.kernel.org with SMTP id <S132398AbRDCRx3>;
	Tue, 3 Apr 2001 13:53:29 -0400
Date: Tue, 3 Apr 2001 19:52:08 +0200
From: clock@ghost.btnet.cz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The 53c400a
Message-ID: <20010403195208.A12046@ghost.btnet.cz>
In-Reply-To: <20010329210453.B4209@ghost.btnet.cz> <E14kBff-0006kK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14kBff-0006kK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 02, 2001 at 10:15:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2001 at 10:15:28PM +0100, Alan Cox wrote:
> Not in the near future.

Never mind. I realized three things:

a) my 53c400 card must be initialized first by DOS driver to be detected by Linux kernel

b) The scanner initialization lasts about 4 minutes. And scanning is very slow
even if I increase the kernel buffer to the max. as described in the SANE doc.

c) Using an adaptec SCSI adapter works just fine: scanner initializes
immediately, card is recognized even without DOS and the scanning is much
faster.

-- 
Karel Kulhavy                     http://atrey.karlin.mff.cuni.cz/~clock
