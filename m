Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWHNTf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWHNTf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbWHNTf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:35:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32469 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752053AbWHNTfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:35:55 -0400
Subject: Re: Getting 'sync' to flush disk cache?
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>
In-Reply-To: <44E0C373.6060008@garzik.org>
References: <44E0C373.6060008@garzik.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 14 Aug 2006 21:34:58 +0200
Message-Id: <1155584098.2886.271.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 14:39 -0400, Jeff Garzik wrote:
> So...  has anybody given any thought to enabling fsync(2), fdatasync(2), 
> and sync_file_range(2) issuing a [FLUSH|SYNCHRONIZE] CACHE command?
> 
> This has bugged me for _years_, that Linux does not do this.  Looking at 
> forums on the web, it bugs a lot of other people too.

eh afaik 2.6.17 and such do this if you have barriers enabled...

