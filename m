Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132932AbRDXQzu>; Tue, 24 Apr 2001 12:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132852AbRDXQzk>; Tue, 24 Apr 2001 12:55:40 -0400
Received: from [63.109.146.2] ([63.109.146.2]:30702 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S132808AbRDXQzY>;
	Tue, 24 Apr 2001 12:55:24 -0400
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1B97@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'imel96@trustix.co.id'" <imel96@trustix.co.id>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Single user linux
Date: Tue, 24 Apr 2001 09:55:14 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> think about personal devices. something like the nokia communicator.
> a system security passwd is acceptable, but that's it. no those-
> device-user would like to know about user account, file ownership,
> etc. they just want to use it.

If you are making a personal device, like an "appliance", there is no 
need to patch the kernel - at least not to remove the concept of users.  

Instead, change your startup scripts.  In that situation, you will have 
a custom application that is automatically started at boot and runs with
enough privileges to do whatever it needs.

The user never sees a login prompt.  If you want a Windows-95 style
setup for Linux, you can do that too - but don't run as root!  Just have
the startup scripts auto-login as an unprivileged user.

Kernel patches to do this are completely unnecessary, and a bad idea.

Permissions are important to have on an appliance-like system, as they 
can be used to help prevent the end user from accessing the guts of the 
system which should be off limits for them.

