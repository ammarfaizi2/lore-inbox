Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266516AbUBQTp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUBQTp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:45:58 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:31930 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S266516AbUBQTp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:45:56 -0500
Date: Tue, 17 Feb 2004 04:40:01 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040217124001.GA1267@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040216190927.GA2969@us.ibm.com> <20040217073522.A25921@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217073522.A25921@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 07:35:22AM +0000, Christoph Hellwig wrote:
> On Mon, Feb 16, 2004 at 11:09:27AM -0800, Paul E. McKenney wrote:
> > Hello, Andrew,
> > 
> > The attached patch to make invalidate_mmap_range() non-GPL exported
> > seems to have been lost somewhere between 2.6.1-mm4 and 2.6.1-mm5.
> > It still applies cleanly.  Could you please take it up again?
> 
> And there's still no reason to ease IBM's GPL violations by exporting
> deep VM internals.  The GPLed DFS you claimed you needed this for still
> hasn't shown up but instead you want to change the export all the time.
> 
> Tells a lot about IBMs promises..

Hello, Christoph!

IBM shipped the promised SAN Filesystem some months ago.  The source
code for the Linux client was released under GPL, as promised, and may
be found at the following URL:

https://www6.software.ibm.com/dl/sanfsys/sanfsref-i?S_PKG=dl&S_TACT=&S_CMP=

A PDF of the protocol specification may be found at the following URL:

http://www.storage.ibm.com/software/virtualization/sfs/protocol.html

These URLs do require that you register, but there is no cost nor any
agreement other than the GPL itself.  The Linux client has not been
shipped as product yet.  The code is still quite rough, which is one
reason that it has not be submitted to, for example, LKML.  ;-)

						Thanx, Paul
