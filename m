Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbQK3WOt>; Thu, 30 Nov 2000 17:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbQK3WOj>; Thu, 30 Nov 2000 17:14:39 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:11012 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129636AbQK3WO3>; Thu, 30 Nov 2000 17:14:29 -0500
Date: Fri, 1 Dec 2000 00:40:49 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Phillip Ezolt <ezolt@perf.zko.dec.com>
Cc: rth@twiddle.net, axp-list@redhat.com, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, clinux@zk3.dec.com,
        wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
Message-ID: <20001201004049.A980@jurassic.park.msu.ru>
In-Reply-To: <Pine.OSF.3.96.1001130145721.15171B-100000@perf.zko.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.OSF.3.96.1001130145721.15171B-100000@perf.zko.dec.com>; from ezolt@perf.zko.dec.com on Thu, Nov 30, 2000 at 03:02:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 03:02:42PM -0500, Phillip Ezolt wrote:
> Qlogic SCSI support seems broken on 2.4.0-test11 on a Miata (Digital Personal WorkStation 600au).
> 
> When starting up, we get a machine check after initialing the qlogic SCSI code. 

Try test12-pre3 - there is the new PCI init stuff. It works (to some degree)
on as1000a with the same qlogic scsi.

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
