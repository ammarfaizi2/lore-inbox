Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbSJQUWY>; Thu, 17 Oct 2002 16:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262022AbSJQUWY>; Thu, 17 Oct 2002 16:22:24 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35854 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261863AbSJQUWW>;
	Thu, 17 Oct 2002 16:22:22 -0400
Date: Thu, 17 Oct 2002 13:28:02 -0700
From: Greg KH <greg@kroah.com>
To: Russell Coker <russell@coker.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017202802.GA592@kroah.com>
References: <20021017195015.A4747@infradead.org> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com> <200210172220.21458.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210172220.21458.russell@coker.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 10:20:21PM +0200, Russell Coker wrote:
>  With the current LSM setup of a 2^32 LSM calls, you can 
> choose a number somewhat arbitarily and be fairly sure that it won't conflict 
> and that you can later register the same number with the LSM people.

You do not have to "register" a syscall number with the LSM people.  We
don't care.  Use whatever you want for your sys_security call.  If you
want to be nice, read the documentation and use a module id that is
unique.

Personally I hate the "module id" idea, but that's just me...

thanks,

greg k-h
