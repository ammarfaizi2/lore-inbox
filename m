Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312463AbSCYRIB>; Mon, 25 Mar 2002 12:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312462AbSCYRHv>; Mon, 25 Mar 2002 12:07:51 -0500
Received: from ns.caldera.de ([212.34.180.1]:3015 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S312463AbSCYRHk>;
	Mon, 25 Mar 2002 12:07:40 -0500
Date: Mon, 25 Mar 2002 18:06:49 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: devfs mounted twice in linux 2.4.19-pre3
Message-ID: <20020325180649.A26703@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Richard Gooch <rgooch@ras.ucalgary.ca>, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203250008.g2P08hr18250@vindaloo.ras.ucalgary.ca> <200203250852.g2P8qr503025@ns.caldera.de> <200203251658.g2PGwf228854@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 09:58:41AM -0700, Richard Gooch wrote:
> This is not a problem with mount(8). It's a kernel problem. When
> sys_umount(..., MNT_DETACH) is called from kernel space, it doesn't
> clean up /proc/mounts.

Oh - I though about /etc/mtab, sorry for misreading..

