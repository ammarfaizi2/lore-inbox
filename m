Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSJQXGW>; Thu, 17 Oct 2002 19:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSJQXGW>; Thu, 17 Oct 2002 19:06:22 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9999 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262420AbSJQXFt>;
	Thu, 17 Oct 2002 19:05:49 -0400
Date: Thu, 17 Oct 2002 16:11:27 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andreas Steinmetz <ast@domdv.de>, "David S. Miller" <davem@redhat.com>,
       hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017231127.GG1682@kroah.com>
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017.131830.27803403.davem@redhat.com> <3DAF3EF1.50500@domdv.de> <3DAF412A.7060702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAF412A.7060702@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 07:00:58PM -0400, Jeff Garzik wrote:
> 
> Finally, I was under the impression that Greg KH agreed that it is 
> possible to eliminate this overhead?  Maybe I recall incorrectly.

I eliminated the overhead at compile time, yes, much like spinlocks.

What would be ideal is if we could do CONFIG_SECURITY=m and only if
someone wants to load a security module, would they incur the overhead.

thanks,

greg k-h
