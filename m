Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUKWSs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUKWSs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUKWSjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:39:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:42963 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261492AbUKWSi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:38:29 -0500
Date: Tue, 23 Nov 2004 10:38:14 -0800
From: Greg KH <greg@kroah.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration) query support
Message-ID: <20041123183813.GA31068@kroah.com>
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com> <20041122713.g6bh6aqdXIN4RJYR@topspin.com> <20041122222507.GB15634@kroah.com> <527jodbgqo.fsf@topspin.com> <20041123064120.GB22493@kroah.com> <52hdnh83jy.fsf@topspin.com> <20041123072944.GA22786@kroah.com> <20041123175246.GD4217@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123175246.GD4217@sventech.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 09:52:46AM -0800, Johannes Erdfelt wrote:
> On Mon, Nov 22, 2004, Greg KH <greg@kroah.com> wrote:
> > To be straightforward, either drop the RCU code completely, or change
> > the license of your code.  
> 
> Or compile against non-GPL RCU code, right?

No.  RCU is covered by a patent that only allows for it to be
implemented in GPL licensed code.  If you want to use RCU in non-GPL
code, you need to sign a license agreement with the holder of the RCU
patent.

This was all covered a few years ago when the RCU code first went into
the kernel tree.  See the lkml archives for details.

So the very usage of RCU in the code is the issue here, not the fact
that it is being linked against a GPL licensed header file.

This isn't a GPL interpretation here, but a patent license agreement
issue.  Sorry for not being clearer the first time around, I thought
everyone was aware of this issue by now.

thanks,

greg k-h
