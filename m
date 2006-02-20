Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWBTQU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWBTQU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWBTQU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:20:59 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:49083 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030305AbWBTQU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:20:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=SkNDy6942uHyrwmF7EYWE4I/VpeaUJl5vxlUQro5A8Z2ZL0cU242glkuosAX9SsuKdCPZdLJ9zn1Hu1LKzJ3WX0mPwcMwl+7TniOsQGjtx3rVGRbfXKN41Rf+WQlBUottzfTE3YV9TNU/NtbEOhMTHT0mX3K306EmFG3yWdBXnk=
Date: Mon, 20 Feb 2006 19:20:49 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Brian Marete <bgmarete@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: ver_linux slightly broken (Re: Oops in Kernel 2.6.16-rc4 on Modprobe of saa7134.ko)
Message-ID: <20060220162049.GA8052@mipter.zuzino.mipt.ru>
References: <6dd519ae0602200504n7d89dcb9j4685f1f0939f9c53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd519ae0602200504n7d89dcb9j4685f1f0939f9c53@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 01:04:24PM +0000, Brian Marete wrote:
> Linux C Library        14 02:33 /lib/libc.so.6

Please, run

	ldd /bin/sh
and
	ls -l /lib/libc*

and post full output. ver_linux needs updating.

