Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTDFNTO (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 09:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTDFNTO (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 09:19:14 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261644AbTDFNTN (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 09:19:13 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304061332.h36DWnaD000165@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH] take 48-bit lba a bit further
To: axboe@suse.de (Jens Axboe)
Date: Sun, 6 Apr 2003 14:32:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20030406130737.GL786@suse.de> from "Jens Axboe" at Apr 06, 2003 03:07:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for taking the previous bit Alan, here's an incremental update to
> 2.5.66-ac2. Just cleans up the 'when to use 48-bit lba' logic a bit per
> Andries suggestion, and also expands the request size for 48-bit lba
> capable drives to 512KiB.
> 
> Works perfectly in testing here, ext2/3 generates nice big 512KiB
> requests and the drive flies.

Then, don't we want to be using 48-bit lba all the time on compatible devices
instead of falling back to 28-bit when possible to save a small amount of
instruction overhead?  (Or is that what we're doing already?  I haven't really
had the time to follow this thread).

John.
