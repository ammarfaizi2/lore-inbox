Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbTFWJMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 05:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265397AbTFWJMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 05:12:20 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:50309 "EHLO
	firewall.ocs.com.au") by vger.kernel.org with ESMTP id S265177AbTFWJMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 05:12:19 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 doesn't boot: /bin/insmod.old: file not found 
In-reply-to: Your message of "22 Jun 2003 19:07:58 +0200."
             <1056301678.2183.10.camel@shrek.bitfreak.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Jun 2003 19:26:06 +1000
Message-ID: <13443.1056360366@firewall.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jun 2003 19:07:58 +0200, 
Ronald Bultje <rbultje@ronald.bitfreak.net> wrote:
>After that, I installed the newest modutils (2.4.25) and
>module-init-tools (tried both 0.9.12 and 0.9.13-pre), created symlinks
>in /bin for all *mod* tools pointing to /sbin/$file, and I still cannot
>get 2.4.21 to get further than this error (obviously, /bin/insmod.old
>_is there_, I'm not that stupid. ;) ). I use initrd with filesystem
>modules and some more in it, so obviously it fails with a panic saying
>that /sbin/init wasn't found (no single HD mounted).

Did you copy /bin/insmod.old to the initrd that you are booting from?
Is /bin/insmod.old a static binary?

