Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVBNSC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVBNSC3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVBNSC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:02:29 -0500
Received: from mol92-1-81-57-137-188.fbx.proxad.net ([81.57.137.188]:43648
	"EHLO laptop.okeru") by vger.kernel.org with ESMTP id S261502AbVBNSCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:02:25 -0500
Message-ID: <4210E7EA.3020301@oreka.com>
Date: Mon, 14 Feb 2005 19:03:22 +0100
From: Alexandre <a.hocquel_NOSPAM_@oreka.com>
Reply-To: a.hocquel@oreka.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: strange bug with realtek 8169 card
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I bought 2 Ovislink GE8169 because they're made with realtek 8169 chipset.
I make a new kernel with r8169 compiled as a module.
I can load r8169.o module without any error or warning. Cards negociate 
at 1000Mb/s, so everything looks ok.
I can ping both from each other.

and now is the strange behavior:
I try a ftp download, and if it's small file I can dowload without a 
problem... ONCE! Because if I "get" the same file (or another one) in 
the same ftp session (or other) it looks like freezing...
If I try to download "big" file (like ie: linux-2.4.29.tar.bz2), it freezes.
In fact after many try, I found that after each dowload (or begin of) I 
can't ping anymore the other pc... I have to down and up the cards (on 
both pc) to have it working again...

The same behavior occurs with scp. And doesn't occur with 10/100 Mb/s 
NIC inside the both same pc.
This problem occurs with 2.4.27, 2.4.28, 2.4.29 kernels... (didn't try 
with "lower" kernels).

If I look in every log file I can (dmesg, kernel.log, syslog, debug) 
there is no message...
Have any idea how to ask more r8169.o module to be more verbose?

Or any idea why the problem occurs and how to correct this (if it is 
possbile)?

thanks by advance,

Alexandre
