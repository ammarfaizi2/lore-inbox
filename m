Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTKPNwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTKPNwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:52:44 -0500
Received: from linux-bt.org ([217.160.111.169]:35011 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262796AbTKPNwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:52:43 -0500
Subject: Re: Fix firmware loader docs
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
In-Reply-To: <20031116133808.GA337@elf.ucw.cz>
References: <20031116131000.GA293@elf.ucw.cz>
	 <1068989412.17638.407.camel@pegasus>  <20031116133808.GA337@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1068990747.19286.417.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 16 Nov 2003 14:52:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > we can remove the hotplug-script from 2.4 and 2.6 completly, because the
> > firmware.agent script is now part of the linux-hotplug scripts and there
> > is no need to write one. You only have to put the firmware file into the
> > firmware directory, which is by default /usr/lib/hotplug/firmware/ and
> > everything works as expected.
> 
> Well, I'd keep them for a while... To stop people wondering "WTF is
> this"?

I don't think so. There is a README that should explain this and the
example hotplug-script should go away, because it confuses more than it
helps. The current one looks very different and is working fine for 2.4
and 2.6. If people don't have a firmware.agent script on their system
they can either update the hotplug utils or use the Internet to find
one.

Regards

Marcel


