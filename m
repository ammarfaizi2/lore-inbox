Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278620AbRJSTZH>; Fri, 19 Oct 2001 15:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278622AbRJSTY6>; Fri, 19 Oct 2001 15:24:58 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:44796 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S278620AbRJSTYr>; Fri, 19 Oct 2001 15:24:47 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 19 Oct 2001 13:25:13 -0600
To: Mike Castle <dalgoda@ix.netcom.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: e2fsck, LVM and 4096-char block problems
Message-ID: <20011019132513.F402@turbolinux.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011019115937.A10588@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011019115937.A10588@thune.mrc-home.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 19, 2001  11:59 -0700, Mike Castle wrote:
> Using Linus' 2.4.10, unpatched.  (Perhaps I need to patch the LVM stuff ;-)

Very bad combination.  Don't use 2.4.10, don't use stock Linus LVM.

> resize2fs tells me to run fsck.  Hmmmm... I just did.

Fsck may not work on 2.4.10.

> Oct 19 11:45:41 thune kernel: ll_rw_block: device 3a:00: only 4096-char
> blocks implemented (1024)

Known problem fixed in more recent LVM.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

