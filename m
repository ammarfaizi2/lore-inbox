Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbRBNQAV>; Wed, 14 Feb 2001 11:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129578AbRBNQAP>; Wed, 14 Feb 2001 11:00:15 -0500
Received: from smtp6.us.dell.com ([143.166.83.101]:42245 "EHLO
	smtp6.us.dell.com") by vger.kernel.org with ESMTP
	id <S129391AbRBNQAA>; Wed, 14 Feb 2001 11:00:00 -0500
Date: Wed, 14 Feb 2001 09:59:58 -0600 (CST)
From: Michael E Brown <michael_e_brown@dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: <Andries.Brouwer@cwi.nl>
cc: <Matt_Domsch@exchange.dell.com>, <linux-kernel@vger.kernel.org>
Subject: Re: block ioctl to read/write last sector
In-Reply-To: <UTC200102141543.QAA79054.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.30.0102140957400.28753-100000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001 Andries.Brouwer@cwi.nl wrote:

>
> Maybe. I think that you'll find that these blocks are
> relative to the start of the partition, not relative
> to the start of the disk.
>
> So if you add a 1-block partition that contains the last
> sector of the disk, all should be fine.
>

Ok. Upon re-reading the code in question, I was too hasty in my
assumptions. This might work, so I'll try it. I don't expect it to be
awfully pretty, though :-(

--
Michael Brown
Linux System Group
Dell Computer Corp

