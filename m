Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTEILex (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTEILew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:34:52 -0400
Received: from verein.lst.de ([212.34.181.86]:60164 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262490AbTEILev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:34:51 -0400
Date: Fri, 9 May 2003 13:47:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unused funcion proc_mknod
Message-ID: <20030509134714.A3837@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Jaroslav Kysela <perex@suse.cz>,
	viro@parcelfarce.linux.theplanet.co.uk, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030505213004.B24006@lst.de> <Pine.LNX.4.44.0305091336060.1237-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0305091336060.1237-100000@pnote.perex-int.cz>; from perex@suse.cz on Fri, May 09, 2003 at 01:43:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 01:43:20PM +0200, Jaroslav Kysela wrote:
> alsa-lib doesn't rely on it at all. The devices in /dev/snd/ might be 
> created in these ways:
> 
> 1) static - using the mknod command
> 2) using devfs
> 3) link /dev/snd to /proc/asound/dev
> 
> We prefered the third solution because we were changing heavily the device
> minor numbers in the past. We can remove the proc dynamic device creating
> from our code now. I agree, this code should not be in the kernel tree.

Okay.  Will you submit the removal as part of the next alsa merge?

