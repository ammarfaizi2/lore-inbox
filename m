Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291927AbSBAThB>; Fri, 1 Feb 2002 14:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291926AbSBATgm>; Fri, 1 Feb 2002 14:36:42 -0500
Received: from femail40.sdc1.sfba.home.com ([24.254.60.34]:41663 "EHLO
	femail40.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S291925AbSBATgV>; Fri, 1 Feb 2002 14:36:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Date: Fri, 1 Feb 2002 14:37:30 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020131.162549.74750188.davem@redhat.com> <E16WRmu-0003iO-00@the-village.bc.nu> <20020131.163054.41634626.davem@redhat.com>
In-Reply-To: <20020131.163054.41634626.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020201193620.IWZK8351.femail40.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 January 2002 07:30 pm, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: Fri, 1 Feb 2002 00:42:44 +0000 (GMT)
>
>    I'd like to eliminate lots of the magic weird cases in Config.in too -
> but by making the language express it. Something like
>
>    tristate_orif "blah" CONFIG_FOO $CONFIG_SMALL
>
> This doesn't solve the CRC32 case.  What if you want
> CONFIG_SMALL, yet some net driver that needs the crc32
> routines?

I thought this was the sort of reason CML2 was invented?

Rob
