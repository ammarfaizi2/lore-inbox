Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUHXSzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUHXSzC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268172AbUHXSzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:55:02 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:32409 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268215AbUHXSyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:54:54 -0400
Date: Tue, 24 Aug 2004 11:54:47 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Linux 2.6.9-rc1
Message-ID: <20040824185447.GA28558@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 12:49:24AM -0700, Linus Torvalds wrote:

> Jens Axboe:
>   o disk barriers: core
>   o disk barriers: IDE
>   o disk barriers: scsi
>   o disk barriers: devicemapper
>   o disk barriers: MD
>   o ext3 barrier support

What are the implications here when using an external journal?

When the log is external the writes can still be reordered and create
potential problems surely?  (ie. write <fs-stuff> <journal thing>
<fs-stuff> and since the <journal thing> is on a separate disk the
ordering will be messed up)...


  --cw
