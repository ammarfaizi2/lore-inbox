Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUBHJdt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 04:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUBHJdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 04:33:49 -0500
Received: from mail.gmx.de ([213.165.64.20]:27337 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263082AbUBHJds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 04:33:48 -0500
X-Authenticated: #420190
Message-ID: <402602B9.1090005@gmx.net>
Date: Sun, 08 Feb 2004 10:34:49 +0100
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vojtech@suse.cz
CC: linux-kernel@vger.kernel.org
Subject: ps/2 mouse problem with KVM switch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Kernel 2.6.2, XFree86 4.3.0

I am using a Logitech MouseMan 2xOptical mouse connected trough a KVM 
switch.

By default the mouse is detected as "ImExPS/2 Logitech Explorer Mouse".

The problem is that the mouse doesn't work. It is too slow and no mouse 
clicks work. If I move it very fast I sometimes get a random click event.

I specify psmouse.proto=bare mouse works OK, but not the wheel :(
(I have seen at least one "lost synchronization").

Specifying psmouse.proto=imps or exps doesn't help.

Without the KVM switch all is ok (as much as I tested under 2.6.0).

Under 2.4 mouse works perfectly, wheel and all.

I am using /dev/input/mice under XF86 (kernel does complain about X 
using direct hardware for keyboard and gives a bunch of errors).

GPM shows the same behavior if I run it (I'm not using it).

What else can I do?

Regards,
MArk

