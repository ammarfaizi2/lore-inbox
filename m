Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276632AbRJBTKD>; Tue, 2 Oct 2001 15:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276623AbRJBTJx>; Tue, 2 Oct 2001 15:09:53 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:34301 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S276632AbRJBTJm>; Tue, 2 Oct 2001 15:09:42 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 2 Oct 2001 13:09:56 -0600
To: Petr Titera <owl@volny.cz>
Cc: rui.ribeiro@case.pt, linux-kernel@vger.kernel.org
Subject: Re: linux kernel 2.4.10 possibly breaks LILO
Message-ID: <20011002130956.G8954@turbolinux.com>
Mail-Followup-To: Petr Titera <owl@volny.cz>, rui.ribeiro@case.pt,
	linux-kernel@vger.kernel.org
In-Reply-To: <01C14B73.9F052000.rui.ribeiro@case.pt> <003a01c14b6d$96e36d10$13a76cc0@NEVSKIJ>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003a01c14b6d$96e36d10$13a76cc0@NEVSKIJ>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2001  20:10 +0200, Petr Titera wrote:
> May be, that it is filesystem dependant (using ext3), but I dont know...
> Looks like effect of blkdev-in-pagecache. I saw something similiar in past
> when I played with loop-like devices.

Yes, it is blkdev-in-pagecache, and it _should_ be fixed in 2.4.11-pre2.
Please upgrade and give it a try.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

