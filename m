Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWCIS4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWCIS4m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 13:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWCIS4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 13:56:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:26384 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751118AbWCIS4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 13:56:42 -0500
Date: Thu, 9 Mar 2006 19:56:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, rolandd@cisco.com, gregkh@suse.de,
       akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 18 of 20] ipath - kbuild infrastructure
Message-ID: <20060309185604.GA24004@mars.ravnborg.org>
References: <ac5354bb50d515de2a5c.1141922831@localhost.localdomain> <ada4q27ld33.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada4q27ld33.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 09:53:04AM -0800, Roland Dreier wrote:
>  > +	depends on 64BIT && (PCIEPORTBUS || X86_HT)
> 
 
>  > --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
>  > +++ b/drivers/infiniband/hw/ipath/Makefile	Thu Mar  9 08:46:47 2006 -0800
> 
> I've been suggesting that new files be called "Kbuild", since Sam has
> deprecated the "Makefile" name.
Eventually - yes.
But not just now. Kbuild was introduced because it was needed in the
top-level directory and it made good sense to do so.
But for now keeping Makefile is a good choice. This is anyway what
people are used to.

	Sam
