Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVAYHd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVAYHd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVAYHd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:33:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5782 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261854AbVAYHdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:33:53 -0500
Date: Tue, 25 Jan 2005 07:33:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc2: vmnet breaks; put skb_copy_datagram back in place
Message-ID: <20050125073352.GA14828@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org> <20050125004117.GB610@speedy.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125004117.GB610@speedy.student.utwente.nl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 01:41:17AM +0100, Sytse Wielinga wrote:
> Linus, could you please put skb_copy_datagram back in place? It's not used
> anymore in the kernel, but the vmnet module (in vmware) still uses this
> interface to skb_copy_datagram_iovec.
> 
> Patch for 2.6.11-rc2 follows. It compiles cleanly; I have not tested it yet,
> but I assume it's okay. I'll test it right after sending this mail and report
> back here if something goes wrong.

Just fix vmware.  Or upgrade to a fixed version that Petr mentioned already.

