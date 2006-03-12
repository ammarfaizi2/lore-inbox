Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751883AbWCLXRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbWCLXRi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWCLXRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:17:38 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:45915 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751883AbWCLXRh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:17:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C5nXco5eCAN/FVo5HmKXkSk7ETNr/hy3xBzaLFMayA0h1OcnWDsAjvQPQHtM1l5KjaKjXPrYajfBFYYltojYtltGJY35E3q8Ki1RafV+jiEerEs11gMIQ8ihq+bDTHD6zz0DAvvgukzvccu8TQ8PU+/PA4BC4K6yvFUVGP233HI=
Message-ID: <6bffcb0e0603121517s79f6a0e9i@mail.gmail.com>
Date: Mon, 13 Mar 2006 00:17:36 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rc6-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060312220218.GA3469@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060312220218.GA3469@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/03/06, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.16-rc6-rt1 tree, which can be downloaded from
> the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/

make modules_install
[snip]
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map  2.
6.16-rc6-rt1; fi
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/sound/core/snd.ko needs
unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/sound/core/snd-pcm.ko
needs unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/sound/core/seq/snd-seq.ko
needs unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/sound/core/seq/snd-seq-virmidi.ko
needs unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/sound/core/oss/snd-pcm-oss.ko
needs unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/net/unix/unix.ko needs
unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/net/sunrpc/sunrpc.ko needs
unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/net/packet/af_packet.ko
needs unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/net/ipv6/ipv6.ko needs
unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/net/ipv4/inet_diag.ko
needs unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/fs/xfs/xfs.ko needs
unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/fs/xfs/xfs.ko needs
unknown symbol there_is_no_init_MUTEX_LOCKED_for_RT_semaphores
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/fs/xfs/xfs.ko needs
unknown symbol mutex_destroy
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/fs/reiserfs/reiserfs.ko
needs unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/fs/nfsd/nfsd.ko needs
unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/fs/ext2/ext2.ko needs
unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/fs/binfmt_misc.ko needs
unknown symbol rt_read_lock
WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/drivers/parport/parport_pc.ko
needs unknown symbol rt_read_lock

Here is config http://www.stardust.webpages.pl/files/rt/2.6.16-rc6-rt1/rt-config

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
