Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271153AbRHTKDa>; Mon, 20 Aug 2001 06:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271155AbRHTKDU>; Mon, 20 Aug 2001 06:03:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59554 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271153AbRHTKDG>;
	Mon, 20 Aug 2001 06:03:06 -0400
Date: Mon, 20 Aug 2001 06:03:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Hartmann <andihartmann@freenet.de>
cc: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.8-ac5 and earlier] fatal mount-problem
In-Reply-To: <3B80DA50.49F43B10@athlon.maya.org>
Message-ID: <Pine.GSO.4.21.0108200602010.1313-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Aug 2001, Andreas Hartmann wrote:

> Hello all,
> 
> 
> If you mount a device like ide-cdrom with the scsi-emulation turned on
> (as modules) and you do the same mount again on the same (not unmounted)
> device, the mount-programm hangs up and never comes back. It doesn't
> recognize, that the device is allready mounted.

strace, please. -ac5 and 2.4.9 have the same code in fs/super.c, so
I really wonder what the hell is happening...

