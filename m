Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTKTW5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbTKTW4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:56:07 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:64526 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263107AbTKTWzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:55:45 -0500
Date: Thu, 20 Nov 2003 23:52:09 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Parick Beard <patrick@p-beard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Smartmedia 2.6.0-test9 problem.
Message-ID: <20031120225209.GA1756@win.tue.nl>
References: <bpcumv$v22$1@sea.gmane.org> <20031118174828.GA26450@axis.demon.co.uk> <pan.2003.11.18.21.51.11.828965@p-beard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.11.18.21.51.11.828965@p-beard.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 09:51:25PM +0000, Parick Beard wrote:

> Thanks for that thought. I only recently found out about that. It led me
> to interpret my problem wrongly the first time.
> Unfortunately  this is not my problem. On a clean boot I can't mount the
> 64mb card in the reader, yet if I plug my camera in I can mount it there.
> The 16mb card however mounts no problem in the reader.

I forgot what kind of reader and what kind of cards you used.
This evening I fixed some problems with sddr09.c on SmartMedia cards
larger than 16 MB.

(patch on request, or on linux-usb)

