Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbUK0Pjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUK0Pjk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 10:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUK0Pjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 10:39:40 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:22023 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261227AbUK0Pji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 10:39:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Z9MkBdo03S9rqcC322myPTKcWEOYRk7YzKbTeDfeWoZaFHI4gRce9wFDZzuJUZy54ZjoEOlEoI2vUrLk5zUN0mQGW2sA/zz3XxnzAkUcrFWRjmBJWKrq8t/lf8lJobS+UfgzB3zbZXu+W9kICU7hIL5Tts5AgRbYztG9eLRM9p4=
Message-ID: <4b3125cc041127073956f967de@mail.gmail.com>
Date: Sat, 27 Nov 2004 23:39:37 +0800
From: Jeffrey Lim <jfs.world@gmail.com>
Reply-To: Jeffrey Lim <jfs.world@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: help with writing a usb mouse driver
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: pls cc me in any replies as i'm not subscribed to the list.

hi guys, i've been trying to write a usb mouse driver for a custom
mouse, but i'm getting stuck.

I previously started out with trying to hack usbmouse.c, but
apparently after a wild goose chase, it seems that that is not the
recommended path to take. It supposedly conflicts with the hid driver,
though in what way i do not know. (If somebody could enlighten me on
this, pls do. Documentation/input/input.txt does not really explain
why).

So now it almost seems as if the only code i have for analysis and as
a sample is the hid code (hid-core.c, hid-input.c, i assume). But the
problem for me is that this code is too complex for me, and really
doesn't offer the easiest way to get started on this project. I'm not
too sure usb-skeleton.c does it either, because it doesn't have the
code for interfacing with the input layer.

While i could take some pointers for interfacing with the input layer
from usbmouse.c, i really don't see how I could differentiate what
code to take, cos heck, that thing doesnt even work (conflicts with
hid), and I don't even know why! (That thing looks pretty ok to me).

Could somebody give me some pointers on how to go about starting my
project, and where I might perhaps be able to get my hands on some
code that i can work with?

I'm using kernel 2.4.20.

Thanks,
-jf
