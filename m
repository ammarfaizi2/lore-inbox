Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbTFWWvB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbTFWWta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:49:30 -0400
Received: from smtp3.knology.net ([24.214.63.13]:33171 "HELO smtp3.knology.net")
	by vger.kernel.org with SMTP id S265547AbTFWWro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:47:44 -0400
Subject: Re: 2.4.21 doesn't boot: /bin/insmod.old: file not found
From: John Shillinglaw <linuxtech@knology.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1056366638.2185.23.camel@shrek.bitfreak.net>
References: <13443.1056360366@firewall.ocs.com.au>
	 <1056366638.2185.23.camel@shrek.bitfreak.net>
Content-Type: text/plain
Organization: 
Message-Id: <1056409308.5888.2.camel@Aragorn>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2003 19:01:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting the same unexplained error message: Can't run
/bin/insmod.old, file doesn't exist, when trying to load jbd.o and
ext3.o. My system is running Redhat 9, and the error occurs with 2.4.21,
and 2.4.22-pre1

I have 2.4.21-rc7-ac1 booting fine. It seems I came across the same
error when first booting from that kernel, but I can't figure out what I
did to make it work.

This is a strange error so I'm not sure what info to post. Not being
able to boot and run on 2.4.21/22 is holding me up from important
projects, so everyone please help, or tell me what info I should send in
order to solve the problem.

John Shillinglaw

On Mon, 2003-06-23 at 14:40, Ronald Bultje wrote:
> Hi Keith,
> 
> On Mon, 2003-06-23 at 11:26, Keith Owens wrote:
> > On 22 Jun 2003 19:07:58 +0200, 
> > Ronald Bultje <rbultje@ronald.bitfreak.net> wrote:
> > >After that, I installed the newest modutils (2.4.25) and
> > >module-init-tools (tried both 0.9.12 and 0.9.13-pre), created symlinks
> > >in /bin for all *mod* tools pointing to /sbin/$file, and I still cannot
> > >get 2.4.21 to get further than this error (obviously, /bin/insmod.old
> > >_is there_, I'm not that stupid. ;) ). I use initrd with filesystem
> > >modules and some more in it, so obviously it fails with a panic saying
> > >that /sbin/init wasn't found (no single HD mounted).
> > 
> > Did you copy /bin/insmod.old to the initrd that you are booting from?
> > Is /bin/insmod.old a static binary?
> 
> /bin/insmod.old is a symlink to the dynamically linked binary in
> /sbin/insmod.old. The static one is in /{s,}bin/insmod.static.old.
> Should I swap them around?
> Also, I did recreate the initrd image (that should be enough, right?),
> but still get the same error on bootup.
> 
> Thanks,
> 
> Ronald

