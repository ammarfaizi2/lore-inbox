Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266087AbTFWSZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbTFWSZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:25:35 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:30470 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S266087AbTFWSZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:25:34 -0400
Subject: Re: 2.4.21 doesn't boot: /bin/insmod.old: file not found
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <13443.1056360366@firewall.ocs.com.au>
References: <13443.1056360366@firewall.ocs.com.au>
Content-Type: text/plain
Message-Id: <1056366638.2185.23.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 23 Jun 2003 20:40:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

On Mon, 2003-06-23 at 11:26, Keith Owens wrote:
> On 22 Jun 2003 19:07:58 +0200, 
> Ronald Bultje <rbultje@ronald.bitfreak.net> wrote:
> >After that, I installed the newest modutils (2.4.25) and
> >module-init-tools (tried both 0.9.12 and 0.9.13-pre), created symlinks
> >in /bin for all *mod* tools pointing to /sbin/$file, and I still cannot
> >get 2.4.21 to get further than this error (obviously, /bin/insmod.old
> >_is there_, I'm not that stupid. ;) ). I use initrd with filesystem
> >modules and some more in it, so obviously it fails with a panic saying
> >that /sbin/init wasn't found (no single HD mounted).
> 
> Did you copy /bin/insmod.old to the initrd that you are booting from?
> Is /bin/insmod.old a static binary?

/bin/insmod.old is a symlink to the dynamically linked binary in
/sbin/insmod.old. The static one is in /{s,}bin/insmod.static.old.
Should I swap them around?
Also, I did recreate the initrd image (that should be enough, right?),
but still get the same error on bootup.

Thanks,

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

