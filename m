Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131760AbRCORj5>; Thu, 15 Mar 2001 12:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131753AbRCORjr>; Thu, 15 Mar 2001 12:39:47 -0500
Received: from smtp1.sentex.ca ([199.212.134.4]:9487 "EHLO smtp1.sentex.ca")
	by vger.kernel.org with ESMTP id <S131760AbRCORjb>;
	Thu, 15 Mar 2001 12:39:31 -0500
Message-ID: <3AB0FCC8.A54396C6@coplanar.net>
Date: Thu, 15 Mar 2001 12:32:56 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Callaway <matt@kindjal.net>
CC: becker@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: Network init script causes 2.2.18 kernel oops (tulip driver)
In-Reply-To: <Pine.LNX.4.32.0103151045490.31295-100000@gummy.wi.securepipe.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Callaway wrote:

> Greetings,
>
> This is a reproducible oops, and my guess is that it's related to
> the tulip driver included in the 2.2.18 source tree.  We're using
> a D-Link 4 port NIC, and it appears that it doesn't work well with
> IPV6 interfaces.

I have had problems with this NIC as well... Redhat's installer/kudzu
tries to use de4x5 (sp?) module ... bad news.  But it works fine using
old_tulip module with only IPv4.  Same with 2.2 series and 2.4 series
kernels. FYI

>
>
> Keywords:  linux kernel-2.2.18 tulip D-Link 4-port NIC DFE-570 TX

