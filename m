Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272210AbRHXQQX>; Fri, 24 Aug 2001 12:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272224AbRHXQQN>; Fri, 24 Aug 2001 12:16:13 -0400
Received: from A7b72.pppool.de ([213.6.123.114]:14604 "EHLO frodo.local")
	by vger.kernel.org with ESMTP id <S272210AbRHXQQI>;
	Fri, 24 Aug 2001 12:16:08 -0400
Date: Fri, 24 Aug 2001 17:50:41 +0200
From: Walter Hofmann <walterh@gmx.de>
To: Fred <fred@arkansaswebs.com>
Cc: Tony Hoyle <tmh@nothing-on.tv>, linux-kernel@vger.kernel.org
Subject: Re: File System Limitations
Message-ID: <20010824175041.G28587@frodo.uni-erlangen.de>
In-Reply-To: <01082316383301.12104@bits.linuxball> <01082318132000.12319@bits.linuxball> <3B858F58.1000606@nothing-on.tv> <01082318405901.12319@bits.linuxball>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <01082318405901.12319@bits.linuxball>; from fred@arkansaswebs.com on Thu, Aug 23, 2001 at 06:40:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Fred wrote:

> glibc-2.2.2-10
> 
> dd if=/dev/zero of=./tgb count=4000 bs=1M
> 
> created file of 2147483647 bytes
> 
> [root@bits /a5]# dd if=/dev/zero of=./tgb count=4000 bs=1M
> File size limit exceeded (core dumped)

core dump???

My old dd terminated with an error in this case.

Do you have a file size limit set (ulimit -a)?

Walter
