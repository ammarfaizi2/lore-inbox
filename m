Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263058AbRFEB2N>; Mon, 4 Jun 2001 21:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbRFEB2D>; Mon, 4 Jun 2001 21:28:03 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:1723 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263058AbRFEB1x>; Mon, 4 Jun 2001 21:27:53 -0400
Message-ID: <3B1C33C5.AB6C8CD0@uow.edu.au>
Date: Tue, 05 Jun 2001 11:20:05 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: safemode <safemode@voicenet.com>
CC: William Montgomery <william@opinicus.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: lowlatency 2.2.19
In-Reply-To: <Pine.LNX.3.96.1010604173410.5728A-100000@thing2.opinicus.com>,
		<Pine.LNX.3.96.1010604173410.5728A-100000@thing2.opinicus.com> <01060420580802.31206@psuedomode>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

safemode wrote:
> 
> this is just a general question about low latency patches on 2.2,   I
> remember hearing about low latency patches for 2.4 not playing well with X
> 4.x, is this true for 2.2 low latency patches as well?

Yes, it would be the case.

Some video cards have a PCI cheat-mode in which they keep
the PCI bus busy until they are ready to accept new
commands, rather forcing a retry.  Figures of up to
twenty milliseconds have been mentioned.  Your X server
*may* support the `PCIRetry' config option which will
defeat this.

Info:

http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-02/1566.html
http://www.zefiro.com/vgakills.txt
http://www.zdnet.com/pcmag/news/trends/t980619a.htm
http://www.research.microsoft.com/~mbj/papers/tr-98-29.html

-
