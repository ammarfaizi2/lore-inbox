Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUHIRQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUHIRQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266770AbUHIRQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:16:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:49623 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266756AbUHIRQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:16:13 -0400
Date: Mon, 9 Aug 2004 10:14:41 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Stephane Jourdois <stephane@rubis.org>,
       Filip Van Raemdonck <filipvr@xs4all.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, zaitcev@yahoo.com
Subject: Re: 2.6.8-rc2-mm1: bluetooth broken?
Message-ID: <20040809171440.GA30882@kroah.com>
References: <20040808191912.GA620@elf.ucw.cz> <1092003277.2773.45.camel@pegasus> <20040809095425.GA12667@debian> <1092046959.21815.15.camel@pegasus> <20040809120705.GA23073@diamant.rubis.org> <1092057843.21815.21.camel@pegasus> <20040809133452.GA24530@diamant.rubis.org> <1092061267.4639.4.camel@pegasus> <20040809151229.GA8651@diamant.rubis.org> <1092070144.4564.6.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092070144.4564.6.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 06:49:05PM +0200, Marcel Holtmann wrote:
> that is the real problem. I never compiled in this new driver. After
> enabling it the machine did some very weird things. It must be somekind
> of luck that your system was still working. Mine doesn't. The problem is
> that the ub driver don't contain the terminating braces for the device
> id entries. You need to apply the following patch to get everything back
> to normal.

Ah, good catch.  Sorry I missed that previously.  I've applied your
patch to my trees.

thanks again.

greg k-h
