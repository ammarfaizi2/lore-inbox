Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290495AbSAQWYE>; Thu, 17 Jan 2002 17:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290496AbSAQWXy>; Thu, 17 Jan 2002 17:23:54 -0500
Received: from chmls16.mediaone.net ([24.147.1.151]:60048 "EHLO
	chmls16.mediaone.net") by vger.kernel.org with ESMTP
	id <S290495AbSAQWXj>; Thu, 17 Jan 2002 17:23:39 -0500
From: "Guillaume Boissiere" <boissiere@mediaone.net>
To: Guillaume Boissiere <boissiere@mediaone.net>, linux-kernel@vger.kernel.org,
        "Tim Pepper" <tpepper@vato.org>
Date: Thu, 17 Jan 2002 17:22:46 -0500
MIME-Version: 1.0
Subject: Re: [STATUS 2.5]  January 17, 2001
Message-ID: <3C470866.5353.10126E20@localhost>
In-Reply-To: <20020117141458.A11402@vato.org>
In-Reply-To: <20020117214752.GA5085@localhost>; from jdomingo@internautas.org on Thu, Jan 17, 2002 at 10:47:53PM +0100
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So are you suggesting I add the following task to my list?
o Finalize new device naming convention (Linus Torvalds)

-- Guillaume



On 17 Jan 2002 at 14:14, Tim Pepper wrote:

> I'm not sure if any of the block changes already include this or if
> this will rekindle the flamewar on devfs, but something's going to need
> to happen with device naming.
> 
> At the very least the upcoming change to the major/minor allocation
> will allow large numbers of block devices and fs/partitions/check.c's
> disk_name() will break.  I think a lot of the scsi code's ready to support
> a large number of devices.  It'd be kind of ugly to have it find them
> and disk_name() give them colliding names or names with odd extended
> characters.
> 
> There's already code out there to allow the sd to find more than 128
> devices and I've seen it in use where there are enough luns to cause
> disk_name() to call them interesting names.
> 
> Tim
> -- 
> *********************************************************
> *  tpepper@vato dot org             * Venimus, Vidimus, *
> *  http://www.vato.org/~tpepper     * Dolavimus         *
> *********************************************************

