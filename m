Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275653AbRIZWQT>; Wed, 26 Sep 2001 18:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275657AbRIZWQJ>; Wed, 26 Sep 2001 18:16:09 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:64525 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275653AbRIZWPx>; Wed, 26 Sep 2001 18:15:53 -0400
Message-ID: <3BB25377.72FFF0D7@zip.com.au>
Date: Wed, 26 Sep 2001 15:15:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David =?iso-8859-1?Q?G=F3mez?= <davidge@jazzfree.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: reparent_to_init
In-Reply-To: <Pine.LNX.4.33.0109262324150.2312-100000@fargo>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gómez wrote:
> 
> Hi, this is another report of the error that some people seems to have
> with 2.4.10 kernel. This message appears on my syslog:
> 
> Sep 26 21:34:41 fargo kernel: task `ifconfig' exit_signal 17 in
> reparent_to_init
> 
> I'm using the 8139too.c driver.
> 

It's just a noisy printk.  I think we need to take the SIGCHLD
out of 8139too.c.  But I need to test it...
