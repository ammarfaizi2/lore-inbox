Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292456AbSCFA1C>; Tue, 5 Mar 2002 19:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292464AbSCFA0w>; Tue, 5 Mar 2002 19:26:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1035 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292456AbSCFA0j>; Tue, 5 Mar 2002 19:26:39 -0500
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 6 Mar 2002 00:41:39 +0000 (GMT)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C84A34E.6060708@evision-ventures.com> from "Martin Dalecki" at Mar 05, 2002 11:51:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iPUx-0004vD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I intend to kill the largely overdesigned taskfile stuff. It's broken
> by design to provide this micro level of device access to *anybody*.
> Operating systems should try to present the functionality of devices
> in a convenient way to the user and not just mapp it directly to
> user space.

Martin - please go and use a macintosh for 8 weeks then come back. The
unix philosophy is make the simple things easy make the complex possible. 
Without that low level IDE access you might as well stop hacking on the IDE
code because eventually nobody will be able to use your IDE code anyway
