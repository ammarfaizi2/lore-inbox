Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbVIPPsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbVIPPsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbVIPPsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:48:50 -0400
Received: from qproxy.gmail.com ([72.14.204.193]:20981 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161168AbVIPPsu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:48:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ovYeSQHh33YD0tVMfhCyB+EzIPQNDddBnzDurQ4SyvJCwfbo+JGIclW3eCR9UuVvhDP2/SB0GMyv6sPmFEO/hyeZcoPHGwpze0ayemEeMjwXHYRbyPAsVx3wVAu1jK3Cdhrh0qXaVaUc8DsbL8cFev+gaBAZy3X+vBTZbAQ1Lcg=
Message-ID: <d120d500050916084839f8c2aa@mail.gmail.com>
Date: Fri, 16 Sep 2005 10:48:47 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] drivers/base: a little speedup and cleanup
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200509161220.j8GCKV37002454@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050916022319.12bf53f3.akpm@osdl.org>
	 <200509161220.j8GCKV37002454@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> Generated in 2.6.14-rc1-mm1 kernel version.
> 
> Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
> ---
> 
>  platform.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> Performance improvement -- we don't need to zero all allocated memory, only a
>        few bytes from the beginning.

Is there any numbers? How much does this speed up save compared to
increased object size?

;)

-- 
Dmitry
