Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVI2Xke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVI2Xke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVI2Xkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:40:33 -0400
Received: from qproxy.gmail.com ([72.14.204.207]:45759 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751391AbVI2Xkc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:40:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XUbST/U0DMXgl9AyD0c8pKO3EbQ/348mCgn6l8sM9fXWIwPJiuo6sXuNVfKd4lu+fKJ9avzQBtgtjGKo1GNoB+E5JVVuUzV80w/rFKbmKNOpEtTPHj9SGJvpGE2RBuE0Bz66ziSblqhXTf214RDVPuRebJy3W4Kf8ONjf8kmC+g=
Message-ID: <6bffcb0e05092916407befe248@mail.gmail.com>
Date: Fri, 30 Sep 2005 01:40:31 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Subject: Re: 2.6.14-rc2-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
In-Reply-To: <433C65F2.4000300@ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050929143732.59d22569.akpm@osdl.org>
	 <433C60B1.8080003@ens-lyon.fr> <20050929155646.757339a9.akpm@osdl.org>
	 <433C65F2.4000300@ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/09/05, Alexandre Buisse <alexandre.buisse@ens-lyon.fr> wrote:
[snip]
> Hi,
>
> gcc-v :
> gcc version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)
>
> This is a pentium-m machine, so not an amd64

I have pentium 4 and everything is ok. I have tested it with 3 gcc versions:

ng02:/usr/src/linux-mm# gcc --version
gcc (GCC) 3.3.5 (Debian 1:3.3.5-13)

ng02:/usr/src/linux-mm# gcc-3.4 --version
gcc-3.4 (GCC) 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)

ng02:/usr/src/linux-mm# gcc-4.1-cvs --version
gcc-4.1-cvs (GCC) 4.1.0 20050917 (experimental)

It maybe a problem with gentoo gcc.

Regards,
Michal Piotrowski
