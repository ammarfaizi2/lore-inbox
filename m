Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267804AbUHEQ51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267804AbUHEQ51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUHEQ4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:56:11 -0400
Received: from the-village.bc.nu ([81.2.110.252]:58301 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267804AbUHEQzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:55:08 -0400
Subject: Re: ide-cd problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040804050144.GB8139@suse.de>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de>
	 <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de>
	 <1091490870.1649.23.camel@localhost.localdomain>
	 <20040803055337.GA23504@suse.de> <20040803161747.GA16293@bliss>
	 <20040804050144.GB8139@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091721152.8042.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 16:52:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-04 at 06:01, Jens Axboe wrote:
> Absolutely not. I've already outlined why in my previous mails I don't
> want to see anything like this, and this patch is even worse than
> filtering. Additionally, you risk breaking existing programs.

Existing broken programs. 

Once you do filtering so you don't need CAP_SYS_RAWIO to lob some
commands at a device that becomes the place to enforce sensible policies
because the filter knows what is "read" and what is "write" so it can do
different checks for say "eject" (read) "write" (write) and "erase
firmware" (raw I/O)

