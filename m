Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265637AbTF2LmM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 07:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265638AbTF2LmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 07:42:12 -0400
Received: from [195.208.223.239] ([195.208.223.239]:2688 "EHLO pls.park.msu.ru")
	by vger.kernel.org with ESMTP id S265637AbTF2LmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 07:42:12 -0400
Date: Sun, 29 Jun 2003 15:56:16 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Oleg Drokin <green@namesys.com>
Cc: "T. Weyergraf" <kirk@colinet.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 on alpha/smp build failure
Message-ID: <20030629155616.B694@pls.park.msu.ru>
References: <kirk-1030628112813.A0111034@hydra.colinet.de> <20030628133818.GA6073@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030628133818.GA6073@namesys.com>; from green@namesys.com on Sat, Jun 28, 2003 at 05:38:18PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 05:38:18PM +0400, Oleg Drokin wrote:
> When I compile the kernel the alpha itself (tried shipped suse 8.1 gcc 3.2.2
> and self-compiled gcc 2.95.3), it jumps to the address zero quickly after
> launching init and panics.

Most likely it's binutils problem. Versions 2.13.90.0.18 and newer
should be OK, as discussed recently on l-k.

Ivan.
