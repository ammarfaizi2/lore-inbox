Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283697AbRL1Ady>; Thu, 27 Dec 2001 19:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283708AbRL1Adp>; Thu, 27 Dec 2001 19:33:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49926 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283697AbRL1Adb>; Thu, 27 Dec 2001 19:33:31 -0500
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
To: adilger@turbolabs.com (Andreas Dilger)
Date: Fri, 28 Dec 2001 00:42:58 +0000 (GMT)
Cc: davej@suse.de (Dave Jones),
        acme@conectiva.com.br (Arnaldo Carvalho de Melo),
        srwalter@yahoo.com (Steven Walter), linux-kernel@vger.kernel.org
In-Reply-To: <20011227171437.P12868@lynx.no> from "Andreas Dilger" at Dec 27, 2001 05:14:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Jl6w-0007RP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rather, the "METOO" section would be handled by just adding a mailing
> list address in the relevant MAINTAINER file.  The above examples would
> be covered by linux-kernel, linux-net, linux-fsdevel, and ext2-devel.

99% of the problem can IMHO be solved by notifying after the event since
we have pre-patches and stuff can be handled after a pre anyway. Then
its

	grep diff for filenames
	mail anyone whose regexp matched the list of filename matches

Alan
