Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966784AbWKTVVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966784AbWKTVVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966771AbWKTVVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:21:37 -0500
Received: from avexch1.qlogic.com ([198.70.193.115]:24447 "EHLO
	avexch1.qlogic.com") by vger.kernel.org with ESMTP id S966784AbWKTVVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:21:36 -0500
Date: Mon, 20 Nov 2006 13:21:33 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-driver@qlogic.com, hch@infradead.org
Subject: Re: [PATCH 2/2] Use mutex_lock_timeout in qla2xxx driver
Message-ID: <20061120212133.GJ11420@andrew-vasquezs-computer.local>
References: <20061109182721.GN16952@parisc-linux.org> <20061109183054.GO16952@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109183054.GO16952@parisc-linux.org>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 20 Nov 2006 21:21:35.0281 (UTC) FILETIME=[DB7F3A10:01C70CE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2006, Matthew Wilcox wrote:

> qla2xxx can use a mutex instead of a semaphore for mailbox serialisation.
> It can also use the new mutex_down_timeout function I introduced in
> patch 1/2.
> 
> Compile-tested only (I don't have a qlogic card conveniently available
> right now).
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Initial testing appears promising.

Ack-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
