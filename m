Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289225AbSA1QIm>; Mon, 28 Jan 2002 11:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289226AbSA1QIc>; Mon, 28 Jan 2002 11:08:32 -0500
Received: from ns.tasking.nl ([195.193.207.2]:9996 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S289225AbSA1QIY>;
	Mon, 28 Jan 2002 11:08:24 -0500
Date: Mon, 28 Jan 2002 17:07:04 +0100
From: Frank van Maarseveen <fvm@altium.nl>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: restoring hard linked files from zisofs/iso9660 w. RR
Message-ID: <20020128170704.A2632@espoo.tasking.nl>
Reply-To: frank.van.maarseveen@altium.nl
In-Reply-To: <20020125135545.A28897@espoo.tasking.nl> <a2s67d$8s0$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a2s67d$8s0$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Jan 25, 2002 at 09:55:57AM -0800
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 09:55:57AM -0800, H. Peter Anvin wrote:
> 
> WHAT doesn't work?
> There is, I belive, an inode number RR attribute.  Last I checked I
> was happily using hard links with RockRidge...

Try restoring a few hard linked files from such a CD. The links will
break because the inodes of hard linked objects on CD do not have
an identical inode number anymore.

-- 
Frank
