Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbTFCD5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 23:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbTFCD5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 23:57:34 -0400
Received: from waste.org ([209.173.204.2]:29380 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264923AbTFCD5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 23:57:33 -0400
Date: Mon, 2 Jun 2003 23:10:54 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jody Pearson <J.Pearson@cern.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Documentation / code sample wanted.
Message-ID: <20030603041054.GM23715@waste.org>
References: <Pine.LNX.4.44.0306021939490.31408-100000@lxplus077.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306021939490.31408-100000@lxplus077.cern.ch>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 07:40:52PM +0200, Jody Pearson wrote:

> I am looking for some source code or a document which outlines how to open 
> a TCP connection within kernel space.

Take a look at nbd or Cisco's iSCSI driver.
 
> For more information, I basically want to emulate a userland 
> gethostbyname() in kernel space.

That gets ugly quickly. There are a lot of options and complexity
needed to handle even the simplest name resolution robustly. It almost
certainly makes more sense to do this in userspace and pass the result
down to the kernel.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
