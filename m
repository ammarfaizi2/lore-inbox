Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319523AbSH2Wxr>; Thu, 29 Aug 2002 18:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319521AbSH2Ww7>; Thu, 29 Aug 2002 18:52:59 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:30205
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319500AbSH2Wv6>; Thu, 29 Aug 2002 18:51:58 -0400
Subject: Re: ide-2.4.20-pre4-ac2.patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10208271503530.24156-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10208271503530.24156-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 29 Aug 2002 23:55:41 +0100
Message-Id: <1030661741.1326.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-27 at 23:17, Andre Hedrick wrote:
> 
> This is out and has been forwarded to AC for review.

Rejected. I found several errors, a couple of strange reverts and some
files being moved to clearly wrong places. It also mixes up multiple
changes.

Andre to make this work I need
	- One change per patch (within reason)
	- An explanation of what it does

For example I've got files you moved and changed, looking at that in
diff is a right pita. I've got a big diff with errors in it (eg gayle in
ppc) I can't easily be sure I can cleanly drop parts of.

Lets start with the file moving. Send me a diff for the Config/Makefile
and a lit of the files to move and where. Gayle I think should be m68k
not ppc (actually Im pretty sure), CMD640 is PCI so why file it in
legacy. "legacy" I took to mean pre PCI rather than "I think its junk"
8)


