Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSG1N4F>; Sun, 28 Jul 2002 09:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSG1N4F>; Sun, 28 Jul 2002 09:56:05 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:58379 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315783AbSG1N4F>; Sun, 28 Jul 2002 09:56:05 -0400
Message-ID: <32918.192.168.0.100.1027865196.squirrel@thuis.zwanebloem.nl>
Date: Sun, 28 Jul 2002 16:06:36 +0200 (CEST)
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
From: "Tommy Faasen" <faasen@xs4all.nl>
To: <greg@kroah.com>
In-Reply-To: <20020711230222.GA5143@kroah.com>
References: <20020711230222.GA5143@kroah.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried to compile 2.5.29, haven't tried dev kernels since 2.5.24 and
it seems that although the nvidia kernel module builds ok when I try to
start X I get a freeze or a reboot. Any chance it has something to do with
this?

> So there I was, trying to remove pci_find_device() and pci_find_class()
> from the 2.5 kernel (it's an old depreciated api, so don't start
> complaining...) when I ran across the agpgart code which uses
> pci_find_class().  I realized I'd have to fix this driver to use the
> "new" pci api if I had a chance of getting rid of pci_find_class(). Dave
> Jones had previously split up this driver into some very nice logical
> parts, and it has been living successfully in his tree for a while now.
>



