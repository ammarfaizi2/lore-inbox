Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTAMRhU>; Mon, 13 Jan 2003 12:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbTAMRhU>; Mon, 13 Jan 2003 12:37:20 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16794
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267431AbTAMRhT>; Mon, 13 Jan 2003 12:37:19 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301130834500.1903-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0301130834500.1903-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042482811.19497.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Jan 2003 18:33:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 16:35, Linus Torvalds wrote:
> On Sun, 12 Jan 2003, Greg KH wrote:
> > 
> > Anyway, here's a patch with your new lock, if you want to apply it.
> 
> I'd like to have some verification (or some test-suite) to see whether it 
> makes any difference at all before applying it.
> 
> Alan, what's your load?

Lots of serial activity (standard PC serial ports) with carrier drops 
present and random oopses appear. I've seen ppp oopses too but don't know
if they are related. I tried duplicating it with pty/tty traffic on a dual
PPro200 and suprisingly that did the same.

Ages ago I chased serial bugs down by doing data transfers between two
PC's while one of them was strobing the carrier up and down on the test
PC with varying frequencies

I've not had time to try that paticular abuse again alas. 

Alan

