Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVHINzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVHINzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbVHINzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:55:53 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:21523 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964777AbVHINzw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:55:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UMeuRnBmwWy7BL2gIekphdf7cFacdqIdd5bAtmAV6z8pPrZjD0TXWvW66dkNmIYPz7wy49Ny/EN4TjGXAsFU0X8Ciw9xFNkacU+fQyxe9sTiDI09jOe/zkOiO0TcLAP/qISgsizOkTWWpkmlVMx5TyEbHxojRd7/iURvRc9zPEc=
Message-ID: <9a87484905080906556d9f531c@mail.gmail.com>
Date: Tue, 9 Aug 2005 15:55:49 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: Soft lockup in e100 driver ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050809133647.GK22165@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050809133647.GK22165@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/05, Matti Aarnio <matti.aarnio@zmailer.org> wrote:
> Running very recent Fedora Core Development kernel I can following
> soft-oops..   ( 2.6.12-1.1455_FC5smp )
> 
Various patches to the e100 driver have been merged since 2.6.12.1
(which is ~1.5months old), so it would make sense to try a more recent
kernel like 2.6.13-rc6, 2.6.13-rc6-git1 or 2.6.13-rc5-mm1 and see if
you can still reproduce the problem with those.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
