Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWG0S1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWG0S1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWG0S1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:27:54 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:17346 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750964AbWG0S1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:27:53 -0400
Subject: Re: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@zeniv.linux.org.uk, tytso@mit.edu, tigran@veritas.com
In-Reply-To: <1154017809.13509.64.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <1154012822.13509.52.camel@localhost.localdomain>
	 <84144f020607270833v4c981d00w8e3e643406aea7a@mail.gmail.com>
	 <1154016589.13509.56.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0607271858380.6287@sbz-30.cs.Helsinki.FI>
	 <1154017809.13509.64.camel@localhost.localdomain>
Date: Thu, 27 Jul 2006 21:27:51 +0300
Message-Id: <1154024871.7190.6.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 17:30 +0100, Alan Cox wrote:
> Actually that isn't true either - it takes care of *regular file*
> writes. Devices will need a revoke hook and thats really probably only
> right. If they don't have one just -EOPNOTSUPP, you can check it before
> you begin any other processing so its easy to check.

I have uploaded patch with ->revoke here:

http://www.kernel.org/pub/linux/kernel/people/penberg/patches/2.6.18-rc2/revoke-system-call-V3.patch

I'll post a new one to LKML after I am done other stuff probably next
week.

			Pekka

