Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSKYGMm>; Mon, 25 Nov 2002 01:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSKYGMm>; Mon, 25 Nov 2002 01:12:42 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:5787
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262457AbSKYGMm>; Mon, 25 Nov 2002 01:12:42 -0500
Date: Mon, 25 Nov 2002 01:23:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to mount root device under .49 (possibly earlier than
 .47)
In-Reply-To: <200211250610.gAP6AcA19907@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.50.0211250122430.1462-100000@montezuma.mastecende.com>
References: <200211250610.gAP6AcA19907@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Peter T. Breuer wrote:

> I found that on 2.5.47. It turned out that I had to give the devfs
> name for the root device. root=/dev/ide/la/la/la.
>
> I had devfs compiled in but not active on boot.
>
>  CONFIG_PROC_FS=y
>  CONFIG_DEVFS_FS=y
>  # CONFIG_DEVFS_MOUNT is not set
>  # CONFIG_DEVFS_DEBUG is not set
>  CONFIG_DEVPTS_FS=y

Thanks for the suggestion but;

zwane@montezuma linux-2.5.49 {0} grep DEVFS .config
# CONFIG_DEVFS_FS is not set

	Zwane
-- 
function.linuxpower.ca
