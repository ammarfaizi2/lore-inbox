Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317007AbSGCNIc>; Wed, 3 Jul 2002 09:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317013AbSGCNIc>; Wed, 3 Jul 2002 09:08:32 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:47099 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317007AbSGCNIb>; Wed, 3 Jul 2002 09:08:31 -0400
Date: Wed, 3 Jul 2002 12:02:35 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Paul Menage <pmenage@ensim.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Filter /proc/mounts based on process root dir
Message-ID: <20020703120235.B1262@linux-m68k.org>
References: <E17PUOo-0003ol-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17PUOo-0003ol-00@pmenage-dt.ensim.com>; from pmenage@ensim.com on Tue, Jul 02, 2002 at 01:37:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 01:37:22PM -0700, Paul Menage wrote:
> 
> This patch causes /proc/mounts to only display entries for mountpoints
> within the current process root. This makes df and friends behave more
> nicely in a chroot jail or with rootfs.

nice feature, also helps chrooted installation work much smoother.

Richard

