Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266282AbUAGRyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUAGRyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:54:52 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:45192 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S266282AbUAGRyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:54:50 -0500
Date: Wed, 7 Jan 2004 09:54:43 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Gabor Burjan <buga@buvoshetes.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 ext3 oops
Message-ID: <20040107175443.GL1882@matchmail.com>
Mail-Followup-To: Gabor Burjan <buga@buvoshetes.hu>,
	linux-kernel@vger.kernel.org
References: <20040107142446.GA12235@odin.sis.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107142446.GA12235@odin.sis.hu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 03:24:46PM +0100, Gabor Burjan wrote:
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing block in system zone - block = 33204
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing block in system zone - block = 502
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1073381983, count = 1
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1073382020, count = 1
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1045139487, count = 1
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing block in system zone - block = 65786 attempt to access beyond end of device 09:02: rw=0, want=663266300, limit=1465216
> EXT3-fs error (device md(9,2)): ext3_free_branches: Read failure, inode=123067, block=1239558398
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 759976007, count = 1
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing block in system zone - block = 33188
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing block in system zone - block = 9
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1071504112, count = 1
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1070875519, count = 1
> EXT3-fs error (device md(9,2)): ext3_free_blocks: Freeing blocks not in datazone - block = 1070875519, count = 1

You need to run fsck on it.

Did it find any errors?

> 
> (see the oops below)
> 

But it shouldn't oops...

Can you reproduce this oops?

> Modules Loaded         ipt_multiport ipt_state ip_conntrack ipt_REJECT iptable_filter ip_tables usbcore

Can you try without iptables?

Mike
