Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbUA1BAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 20:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265687AbUA1BAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 20:00:38 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:8691 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S265452AbUA1BAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 20:00:33 -0500
Date: Wed, 28 Jan 2004 02:00:30 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: MO: opening for write in cdrom.c
In-Reply-To: <20040128000216.GD11683@suse.de>
Message-ID: <Pine.LNX.4.44.0401280159040.843-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004, Jens Axboe wrote:

> Alright, this is your version plus write protect io error handling.
> Could you check if this works for you?

Works for me. I've tested the fallback by making mo_open_write always 
succeed and then inserting a write-protected disc.

I now only get one error report from the drive, the rest of the
writes are correctly denied before hitting the drive.

-- 
Ciao,
Pascal

