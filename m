Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWGDWSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWGDWSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 18:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGDWSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 18:18:11 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:39329 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932273AbWGDWSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 18:18:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OcNQbVcRU3u96IbGx1VndfHh1liw5ZCS6tPGUNDcH48W0i+A3HAhM2e8+BRmQr65izuYZRcj0IsxNvj50STxWkelkNR3h8L1wbQ5YwifBKFUfh2OU981DlEJHpmvdBmuXv++xMoN33Ik5nFaQS+KAuACIwCKFRdgxwdYGfILjk0=
Message-ID: <6bffcb0e0607041518s6604baa6k7d7a8d89a7a4e1fa@mail.gmail.com>
Date: Wed, 5 Jul 2006 00:18:09 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: [TRIVIAL][PATCH] include/linux/Kbuild devfs fix
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "David Woodhouse" <dwmw2@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060704214409.GA23221@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44AACE30.3000601@gmail.com> <20060704214409.GA23221@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/06, Greg KH <gregkh@suse.de> wrote:
> On Tue, Jul 04, 2006 at 10:23:12PM +0200, Michal Piotrowski wrote:
> > Hi,
> >
> > I get this error while "make O=/dir headers_install"
> >
> > sed: can't read /usr/src/linux-git/include/linux/devfs_fs.h: No such file or directory
> > make[3]: *** [devfs_fs.h] Error 2
> > make[2]: *** [linux] Error 2
> > make[1]: *** [headers_install] Error 2
> > make: *** [headers_install] Error 2
> >
> > Here is a patch
>
> Linus already caught this :)

Thanks Linus!

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
