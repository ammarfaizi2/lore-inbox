Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310253AbSCGJxt>; Thu, 7 Mar 2002 04:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310254AbSCGJxj>; Thu, 7 Mar 2002 04:53:39 -0500
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:42105 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S310253AbSCGJxW>; Thu, 7 Mar 2002 04:53:22 -0500
Date: Thu, 7 Mar 2002 09:53:01 +0000
To: linux-kernel@vger.kernel.org
Cc: atai@atai.org
Subject: Re: "layered" block devices and deadlock problems
Message-ID: <20020307095301.GA1571@fib011235813.fsnet.co.uk>
In-Reply-To: <20020307091311.16356.qmail@web10507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020307091311.16356.qmail@web10507.mail.yahoo.com>
User-Agent: Mutt/1.3.27i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 01:13:11AM -0800, Andy Tai wrote:
> Hi, I have been trying to write a kernel driver for a
> "layered" block device, that is, a virtual device
> which sits on top of actual physical devices and
> redirects read/write requests to them.

There are three examples of this that you can look at: software raid
(drivers/md/md.c), LVM (drivers/md/lvm*.c), and the device mapper
(ftp://ftp.sistina.com/pub/LVM2/device-mapper).  I'm biased so would
recommend starting with dm.c in device-mapper.

- Joe
