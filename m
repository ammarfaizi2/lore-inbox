Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSK0L40>; Wed, 27 Nov 2002 06:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSK0L40>; Wed, 27 Nov 2002 06:56:26 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:62728 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262317AbSK0L4Z>; Wed, 27 Nov 2002 06:56:25 -0500
Date: Wed, 27 Nov 2002 13:03:23 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe 
In-Reply-To: <11412.1038394511@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0211271234560.2109-100000@serv>
References: <11412.1038394511@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Nov 2002, Keith Owens wrote:

> cat > .force_default <<EOF
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> EOF
> make allmodconfig 
> 
> That used to work, until 2.5.48.  Being able to force selected options
> and have the rest of the options default to all Y or all M was
> extremely useful.  What a pity that Kconfig removed this facility.

It's not that difficult to reimplement, but it was an undocumented 
feature, so I'd rather concentrated on the rest and waited until one of a 
few people who knew about this feature would complain.

bye, Roman

