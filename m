Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSJQWOA>; Thu, 17 Oct 2002 18:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262226AbSJQWN7>; Thu, 17 Oct 2002 18:13:59 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:65038 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262224AbSJQWN7>;
	Thu, 17 Oct 2002 18:13:59 -0400
Date: Thu, 17 Oct 2002 15:19:38 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017221938.GA1682@kroah.com>
References: <20021017205830.GD592@kroah.com> <20021017.135832.54206778.davem@redhat.com> <20021017220956.GC1533@kroah.com> <20021017.150722.101474043.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017.150722.101474043.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 03:07:22PM -0700, David S. Miller wrote:
>    
>    I would love to implement it in such a manner.  Without using
>    self-modifying code, do you have any ideas of how this could be done?
>    
> Yes, I agree it's a difficult problem.
> 
> My main point is, don't compare the security bloat to USB, because in
> the USB case if I don't use it I get no space/time consumption even if
> I have it enabled (as a module).  This is not true for the security
> bits.

Agreed, I shouldn't have made that comparison in the first place, sorry.

Even if I do view the USB code as bloat at times... :)

greg k-h
