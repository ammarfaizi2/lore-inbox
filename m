Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbQJ1LQU>; Sat, 28 Oct 2000 07:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129583AbQJ1LQJ>; Sat, 28 Oct 2000 07:16:09 -0400
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:144 "EHLO
	mailgate1.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S129480AbQJ1LQA>; Sat, 28 Oct 2000 07:16:00 -0400
Date: Sat, 28 Oct 2000 13:15:58 +0200
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Pavel Machek <pavel@suse.cz>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kernel/module.c (plus gratuitous rant)
Message-ID: <20001028131558.A17429@uni-mainz.de>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Pavel Machek <pavel@suse.cz>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20001027194513.A1060@bug.ucw.cz> <4309.972694843@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <4309.972694843@ocs3.ocs-net>; from kaos@ocs.com.au on Sat, Oct 28, 2000 at 12:00:43PM +1100
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 12:00:43PM +1100, Keith Owens wrote:
> On Fri, 27 Oct 2000 19:45:13 +0200, 
> Pavel Machek <pavel@suse.cz> wrote:
> >Would it be possible to keep 2.7.2.3? You still need 2.7.2.3 to
> >reliably compile 2.0.X (and maybe even 2.2.all-but-latest?).
> 
> You can have multiple versions of gcc installed, just select the one to
> use when you compile the kernel.
> 
> CC=gcc-2723 make 2.0 kernel
> CC=gcc-2723 make 2.2 kernel
> CC=egcs make 2.4 kernel

Even simpler: "gcc -V 2.7.2.3" or "gcc -V 2.95.2" or whatever...

Yours,
  Dominik Kubla
-- 
http://petition.eurolinux.org/index_html - No Software Patents In Europe!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
