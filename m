Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbRHTVBK>; Mon, 20 Aug 2001 17:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269385AbRHTVBA>; Mon, 20 Aug 2001 17:01:00 -0400
Received: from [209.202.108.240] ([209.202.108.240]:29960 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S269354AbRHTVAt>; Mon, 20 Aug 2001 17:00:49 -0400
Date: Mon, 20 Aug 2001 17:00:51 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: =?iso-8859-1?Q?Carlos_Fern=E1ndez_Sanz?= 
	<cfs-lk@fulanito.nisupu.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Fw: select(), EOF...
In-Reply-To: <008701c129ba$8db6ae20$0414a8c0@10>
Message-ID: <Pine.LNX.4.33.0108201659080.11734-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Carlos Fernández Sanz wrote:

> How come the process is never runnable unless there's new data in the file?
> If it was opening and closing the file continously it would be using lots of
> CPU, while it's 0 if there's no data coming.

It sleep()s between close() and open().

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

