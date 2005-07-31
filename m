Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVGaV2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVGaV2X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 17:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVGaV2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 17:28:23 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:2203 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261798AbVGaV1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 17:27:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Jeo7NqvW6INDU0ybJ5Z8tCUGWNUUQtok/UnWKy5F+fSx7p9Ws1t1dh2iDp5vd84v7zuUz5+HW+lFK+Wxk9yplkK6nWpn7PsEnvAkbqYBWJtnuKyaZJ1ppQyDUAviG7XeHANeBZIpWU4R/DZkGerH/9tu3PgG5qUF3TGFg/hDp4I=
Date: Mon, 1 Aug 2005 01:35:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesus Delgado <jdelgado@gmail.com>, Brad Barnett <bahb@l8r.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Acer Aspire 1691WCLi no boot problem
Message-ID: <20050731213544.GA17057@mipter.zuzino.mipt.ru>
References: <20050729122015.73165b54@be.back.l8r.net> <5786143705072910011b280f67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5786143705072910011b280f67@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 12:01:26PM -0500, Jesus Delgado wrote:
>   Iam have is the same problems with emachines M6807.
> On 7/29/05, Brad Barnett <bahb@l8r.net> wrote:
> > I have a very odd problem with an Acer Aspire 1691WCLi.  This laptop will
> > simply not boot with any Debian precompiled kernel, with the exception of
> > Debian's 2.4.27-2 initrd kernel.  I have compiled my own kernels, using a
> > vast array of options, 2.6.11, 2.6.12, 2.6.12.3, 2.6.13-rc4 and 2.4.27,
> > they also all fail in exactly the same way.  I have tried with and without
> > initrd, acpi, 386 or other processor options, as well as very lean,
> > stripped down kernels.  I have tried with both lilo and grub, but both
> > result in the same hang.
> > 
> > Lilo or grub boots the kernel, and I see the classic:
> > 
> > boot: vmlinuz
> > Loading vmlinuz.................................................
> > BIOS data check successful
> > Uncompressiong Linux... Ok. booting the kernel.

I've filed a bug at kernel bugzilla, so yours reports won't be lost.
See http://bugzilla.kernel.org/show_bug.cgi?id=4975

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.

