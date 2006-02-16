Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWBPGxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWBPGxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 01:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWBPGxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 01:53:20 -0500
Received: from smtp-out-01.utu.fi ([130.232.202.171]:32960 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S932477AbWBPGxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 01:53:19 -0500
Date: Thu, 16 Feb 2006 08:53:16 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: readahead logic and I/O errors
In-reply-to: <43F39089.2050302@tls.msk.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <200602160853.16297.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <43F39089.2050302@tls.msk.ru>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 22:35, Michael Tokarev wrote:

> after FIRST I/O error, linux continued trying reading-ahead,
> discovering more and more failed blocks, as dmesg said.

Sorry for hijacking the thread, but on another note, is there
anyway to tell linux to tell the drive to not bother retrying
read errors? Would be perfect for streaming video from a
CD or DVD. Usually video players have excellent error
recovery themselves, which probably looks better on the
screen than the movie coming to a grinding halt due to
the retries.

I remember this being discussed quite some time ago,
but I don't remember if anything came out of it?
