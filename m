Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSCSS3f>; Tue, 19 Mar 2002 13:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289606AbSCSS3U>; Tue, 19 Mar 2002 13:29:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40973 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289272AbSCSS27>; Tue, 19 Mar 2002 13:28:59 -0500
Subject: Re: setrlimit and RLIM_INFINITY causing fsck failure, 2.4.18
To: pdh@utter.chaos.org.uk (Peter Hartley)
Date: Tue, 19 Mar 2002 18:44:32 +0000 (GMT)
Cc: adilger@clusterfs.com (Andreas Dilger), linux-kernel@vger.kernel.org
In-Reply-To: <008301c1cf72$ce5801a0$2701230a@electronic> from "Peter Hartley" at Mar 19, 2002 06:20:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nOb2-0008Pk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is the fix just as simple as: (untested) (and with a mailer than mangles
> tabs)

Test it and see 8)

> All this rlimit stuff is a bit wonky in the presence of 64-bit file sizes
> anyway. Perhaps if we fix just the block-device case we can brush the rest
> under the carpet?

For 64bit platforms life is ok, for the x86 rlimit64 might make sense. Im
not sure if it ever appeared in any standards 8(

