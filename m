Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUFTXPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUFTXPm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 19:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUFTXPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 19:15:42 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:29710 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262768AbUFTXPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 19:15:25 -0400
Date: Mon, 21 Jun 2004 01:15:16 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Dominik Karall <dominik.karall@gmx.net>, florin@iucha.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mgregan@jadeworld.com
Subject: Re: linux-2.6.7-bk2 runs faster than linux-2.6.7 ;)
Message-ID: <20040620231516.GA16617@pclin040.win.tue.nl>
References: <20040619210714.GD3243@iucha.net> <200406200117.38691.dominik.karall@gmx.net> <20040619160532.49934355.akpm@osdl.org> <200406200207.16399.dominik.karall@gmx.net> <20040619162322.1d15c2dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619162322.1d15c2dd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: COLLEGEOFNEWCALEDONIA: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 04:23:22PM -0700, Andrew Morton wrote:

> The dmesg output is incomplete.  You'll need to use `dmesg -s 1000000' to
> get all of it.
> 
> I wish that would get fixed actually.  Seems a bit silly, and current
> kernels permit querying of the ringbuffer size.

Hi Andrew - not so impatient.
Of course I fixed dmesg before I fixed the kernel.

From: Matthew Gregan <mgregan@jadeworld.com>

: Hi Andries,
:  
: Attached is a small patch to dmesg that adds support for the new
: functionality in kernel 2.6.6 and upwards to read the size of the kernel
: message ring buffer.

Thanks!
However, dmesg already has this code.

Andries


