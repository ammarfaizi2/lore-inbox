Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVELGrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVELGrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 02:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVELGrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 02:47:31 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:57759 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261213AbVELGrN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 02:47:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FvIrq6aqEDT7syFVK5Y8gRKMY1yZVE831YPl+/jgiXUMbw5UauOYBVc+wghNMuXzx1WuGK0bDo25rY0pEHwKwmv3oT1/lUjwL7OIwfvGsRNoJwaPOFJ5AkX0Xmy9YgJ1OVw9gulZG2zGkJUw0QS3+T5b5389viRDXoNb9E7F3U8=
Message-ID: <40a4ed5905051123471c3512aa@mail.gmail.com>
Date: Thu, 12 May 2005 08:47:09 +0200
From: Zeno Davatz <zdavatz@gmail.com>
Reply-To: Zeno Davatz <zdavatz@gmail.com>
To: Laurent CARON <lcaron@apartia.fr>
Subject: Re: Kernel Panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,3)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <428238B7.7070207@apartia.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <40a4ed5905051107255848f6b1@mail.gmail.com>
	 <428238B7.7070207@apartia.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/05, Laurent CARON <lcaron@apartia.fr> wrote:
> Zeno Davatz a écrit :

> >I'm trying to set up a new server with 2*200GB HD's, 2*Intel Xeon 3.4
> >GHz and an Intel SE7520BD2 Motherboard (SATA).
> >
> >I can boot perfectly fine from my Gentoo 2005.0 - minimal-install CD.
> >The system is up and running except when I want to boot from the
> >harddisk (root=/dev/sda3 boot=/dev/sda1, both on jfs). I can proof
> >that by mounting the new system when I boot from CD and do a chroot.
> >
> >I even tried by compiling the kernel with the /proc/config.gz from the
> >above CD. Same result as in the subject line:
> >Kernel Panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,3)
> >
> >Yes, I did run lilo -v and that went smoothly; and I do get the Lilo
> >manager in the beginning, but after that and some messages: Kernel
> >panic...
> >
> >I'm on 2.6.11.8 from kernel.org
> >
> >
> >
> did you try using Linux root=/dev/hda3 boot=/dev/hda1 ?

Do you mean I should try that in Liilo or in fstab? When I boot from
CD I can clearly see /dev/sda3 and /dev/sda1.

Thanks for your help
Zeno
