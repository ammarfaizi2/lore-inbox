Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVCUUg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVCUUg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVCUUgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:36:18 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:2438 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261874AbVCUUdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:33:24 -0500
Date: Mon, 21 Mar 2005 21:32:40 +0100
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Problems with connect/disconnect cycles
Message-ID: <20050321203240.GA26901@gamma.logic.tuwien.ac.at>
References: <20050321090537.GI14614@gamma.logic.tuwien.ac.at> <Pine.LNX.4.44L0.0503211513090.2329-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.0503211513090.2329-100000@ida.rowland.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mär 2005, Alan Stern wrote:
> > I found that my builtin sd card reader connected via USB port
> > experiences several connect/reconnect cycles every time I boot.
> 
> > I guess that this should not be the expected behaviour. Now the question
> > is wether this is a problem with -mm or with usb stuff?
> 
> You mean, a software problem or a hardware problem?

So I believe that this is a regression error in 2.6.11-mm something.

> One way to find out is to try going back to an earlier kernel.  When you
> do, do these cycles continue to appear?

Good question. I have nothing older then 2.6.11-mm2 lying around. Can
you give me a hint on *where* I should start? Something like when there
was a great change in usb code incorporated into bk-usb and thus -mm?

I will try 2.6.10-mm3 where I have a home made .deb lying around and
will report back.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
AITH (n.)
The single bristle that sticks out sideways on a cheap paintbrush.
			--- Douglas Adams, The Meaning of Liff
