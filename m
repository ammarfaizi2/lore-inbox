Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWCLXgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWCLXgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWCLXgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:36:12 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:2154 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751926AbWCLXgM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:36:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YYEwCREWYs2rqnmk3yb0XHk1sTHbdeKnIrLq3yN14srBPUvMeDb4y3Dim8LRYm9G363lknVXir1Sdyd3DjXGLZggbZrZl6h+z7H5tCPAau3pEGJni/QZhOF4GRDJpr2ebZFpgOd4BDEOcEBsb74B2Iyp5u9TIx4xlwnlqnhGOaw=
Message-ID: <6bffcb0e0603121536n61be10aaj@mail.gmail.com>
Date: Mon, 13 Mar 2006 00:36:11 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rc6-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0603121517s79f6a0e9i@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060312220218.GA3469@elte.hu>
	 <6bffcb0e0603121517s79f6a0e9i@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi,
>
> On 12/03/06, Ingo Molnar <mingo@elte.hu> wrote:
> > i have released the 2.6.16-rc6-rt1 tree, which can be downloaded from
> > the usual place:
> >
> >    http://redhat.com/~mingo/realtime-preempt/
>
> make modules_install
[snip]
> WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/drivers/parport/parport_pc.ko
> needs unknown symbol rt_read_lock
>
> Here is config http://www.stardust.webpages.pl/files/rt/2.6.16-rc6-rt1/rt-config

make
[..]
Root device is (8, 1)
Boot sector 512 bytes.
Setup is 6894 bytes.
System is 1351 kB
*** Warning: "rt_read_lock" [sound/core/snd.ko] undefined!
*** Warning: "rt_read_lock" [sound/core/snd-pcm.ko] undefined!
*** Warning: "rt_read_lock" [sound/core/seq/snd-seq.ko] undefined!
*** Warning: "rt_read_lock" [sound/core/seq/snd-seq-virmidi.ko] undefined!
*** Warning: "rt_read_lock" [sound/core/oss/snd-pcm-oss.ko] undefined!
*** Warning: "rt_read_lock" [net/unix/unix.ko] undefined!
*** Warning: "rt_read_lock" [net/sunrpc/sunrpc.ko] undefined!
*** Warning: "rt_read_lock" [net/packet/af_packet.ko] undefined!
*** Warning: "rt_read_lock" [net/ipv6/ipv6.ko] undefined!
*** Warning: "rt_read_lock" [net/ipv4/inet_diag.ko] undefined!
*** Warning: "mutex_destroy" [fs/xfs/xfs.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores"
[fs/xfs/xfs.ko] undefined!
*** Warning: "rt_read_lock" [fs/xfs/xfs.ko] undefined!
*** Warning: "rt_read_lock" [fs/reiserfs/reiserfs.ko] undefined!
*** Warning: "rt_read_lock" [fs/nfsd/nfsd.ko] undefined!
*** Warning: "rt_read_lock" [fs/ext2/ext2.ko] undefined!
*** Warning: "rt_read_lock" [fs/binfmt_misc.ko] undefined!
*** Warning: "rt_read_lock" [drivers/parport/parport_pc.ko] undefined!

Here is buildlog
http://www.stardust.webpages.pl/files/rt/2.6.16-rc6-rt1/rt-buildlog

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
