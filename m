Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTJJMv1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 08:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTJJMv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 08:51:27 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:23566 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262115AbTJJMvO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 08:51:14 -0400
Date: Fri, 10 Oct 2003 14:50:52 +0200
From: Willy Tarreau <willy@w.ods.org>
To: SMS WebMaster <sms@4-sms.com>
Cc: "list, linux-kernel" <linux-kernel@vger.kernel.org>,
       linux-config@vger.kernel.org, linux-userfs@vger.kernel.org
Subject: Re: mount: / mounted already or bad option
Message-ID: <20031010125052.GB7202@alpha.home.local>
References: <3F86C17A.8060209@4-sms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F86C17A.8060209@4-sms.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 05:26:02PM +0300, SMS WebMaster wrote:
>  Hi
> I have Gentoo linux in my PC
> I just installed the kernel 2.4.22 and compile it and install it (using 
> genkernel command)
> Right now if I reboot my PC with my new kernel I got :
> mount: / mounted already or bad option
> and the system stop and ask me to type the root password
> and when I login with the root and type
> mount -o remount,rw /
> 
> I got the same message
> mount: / mounted already or bad option
> 
> but if I write
> mount -o remount,rw /dev/hda4  /
> then the root filesystem if remounted as read/write

wouldn't your /etc/mtab be a link to /proc/self/mounts with /proc not mounted ?

Willy

