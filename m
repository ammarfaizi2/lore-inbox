Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263325AbUDUQKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUDUQKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUDUQKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:10:33 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:36104 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263325AbUDUQKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:10:06 -0400
Date: Wed, 21 Apr 2004 17:09:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: raven@themaw.net
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc1-mm1
Message-ID: <20040421170958.A7784@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, raven@themaw.net,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419202538.A15701@infradead.org> <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au> <20040419182657.7870aee9.akpm@osdl.org> <20040421100835.A3577@infradead.org> <Pine.LNX.4.58.0404212022370.3740@donald.themaw.net> <20040421141829.A5551@infradead.org> <Pine.LNX.4.58.0404212348510.16711@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0404212348510.16711@donald.themaw.net>; from raven@themaw.net on Wed, Apr 21, 2004 at 11:52:18PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 11:52:18PM +0800, raven@themaw.net wrote:
> > Any chance to use list_for_each_entry here?
> 
> It looks to me like this macro can't be used for a tree traversal.
> Please enlighten me if I'm wrong.

Umm, indeed.  The control flow in that function is a little too convoluted :)

