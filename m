Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVCJPqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVCJPqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVCJPqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:46:01 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:32798 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262670AbVCJPpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:45:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cmEezUqLSKTGm3R0NBKgfYRwknIPHrNZiECMpnUlZdm1z+OY7N8IpKroquzqcPc1kipuMD8vYH/8nTquDOP3wOA2EbIP6dS7i2w4mE8ZZm/Y4as9MeVH6KtiBIab84OkS4W2MQy0PZp9kIICa1ImSLtiGhErmX6ATF3yFjR3WpU=
Message-ID: <9e473391050310074556aad6b0@mail.gmail.com>
Date: Thu, 10 Mar 2005 10:45:25 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: current linus bk, error mounting root
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310153151.GY2578@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105030909031486744f@mail.gmail.com>
	 <422F2F7C.3010605@pobox.com>
	 <9e4733910503091023474eb377@mail.gmail.com>
	 <422F5D0E.7020004@pobox.com>
	 <9e473391050309125118f2e979@mail.gmail.com>
	 <20050309210926.GZ28855@suse.de>
	 <9e473391050309171643733a12@mail.gmail.com>
	 <20050310075049.GA30243@suse.de>
	 <9e4733910503100658ff440e3@mail.gmail.com>
	 <20050310153151.GY2578@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 16:31:51 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Mar 10 2005, Jon Smirl wrote:
> > LABEL=/                 /                       ext3    defaults        1 1
> > label / is on /dev/sda6
> >
> > Creating root device
> > Mounting root filesystem
> > mount: error 6 mounting ext3
> 
> if 6 is the errno, it looks like it is trying to open a device that does
> not exist (ENXIO). Can you up the verbosity of those commands, I'd like
> to see what it is doing exactly.

Jeff, how can I up the verbosity? This is on Fedora Core 3 but before
user space is up. Is there some way to tell the boot ramdisk to
display more info?


> 
> --
> Jens Axboe
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
