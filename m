Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbSLKBec>; Tue, 10 Dec 2002 20:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSLKBec>; Tue, 10 Dec 2002 20:34:32 -0500
Received: from ip68-4-84-248.oc.oc.cox.net ([68.4.84.248]:20379 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S266952AbSLKBeb>; Tue, 10 Dec 2002 20:34:31 -0500
Date: Tue, 10 Dec 2002 17:42:16 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
Cc: Petr Sebor <petr@scssoft.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE feature request & problem
Message-ID: <20021211014216.GE17498@ip68-4-86-174.oc.oc.cox.net>
References: <068d01c29d97$f8b92160$551b71c3@krlis> <1039312135.27904.11.camel@irongate.swansea.linux.org.uk> <20021208234102.GA8293@scssoft.com> <021401c2a05d$f1c72c80$551b71c3@krlis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021401c2a05d$f1c72c80$551b71c3@krlis>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 04:07:54PM +0100, Milan Roubal wrote:
> Nov 28 17:54:04 fileserver kernel: ide6: reset: master: error (0x7f?)
                                                                 ^^^^
> Nov 28 17:54:14 fileserver kernel: hdn: lost interrupt
> Nov 28 17:54:14 fileserver kernel: hdn: set_multmode: status=0x7f {
                                                               ^^^^
> DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
> Nov 28 17:54:14 fileserver kernel: hdn: set_multmode: error=0x7f {
                                                              ^^^^
> DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound
> AddrMarkNotFound }, LBAsect=8830595334015, high=526344, low=8355711,
> sector=196817664
> Nov 28 17:54:24 fileserver kernel: hdn: lost interrupt
> Nov 28 17:54:24 fileserver kernel: hdn: recal_intr: status=0x7f { DriveReady
                                                             ^^^^
> DeviceFault SeekComplete DataRequest CorrectedError Index Error }
> Nov 28 17:54:24 fileserver kernel: hdn: recal_intr: error=0x7f {
                                                            ^^^^
> DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound
> AddrMarkNotFound }, LBAsect=8830595334015, high=526344, low=8355711,
> sector=196817664
> Nov 28 17:54:24 fileserver kernel: PDC202XX: Primary channel reset.
> Nov 28 17:54:24 fileserver kernel: ide6: reset: master: error (0x7f?)
                                                                 ^^^^
Hmmm... 0x7f... Christmas lights? ;)

Just pointing this out in case nobody else noticed and in case it might
help troubleshoot the problem.

-Barry K. Nathan <barryn@pobox.com>
