Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313702AbSD2RkU>; Mon, 29 Apr 2002 13:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313762AbSD2RkT>; Mon, 29 Apr 2002 13:40:19 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:3850 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313702AbSD2RkS>; Mon, 29 Apr 2002 13:40:18 -0400
Date: Mon, 29 Apr 2002 19:40:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
In-Reply-To: <3CCD811E.8689F4B0@redhat.com>
Message-ID: <Pine.LNX.4.21.0204291937430.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Apr 2002, Arjan van de Ven wrote:

> I'm not convinced of that. It's not nearly a critical path and it's
> better to get even the "dumb" drivers safe than to risk having big
> security holes in there for years to come.

The BKL doesn't make a driver safe, remember that it's released on
schedule.

bye, Roman

