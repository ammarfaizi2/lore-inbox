Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265663AbUGTFvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUGTFvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 01:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265668AbUGTFvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 01:51:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8876 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265663AbUGTFvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 01:51:31 -0400
Date: Mon, 19 Jul 2004 22:51:04 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4 Backport] x445 usb legacy fix
Message-Id: <20040719225104.7defc877@lembas.zaitcev.lan>
In-Reply-To: <20040720051353.GD313@ucw.cz>
References: <1090289222.1388.461.camel@cog.beaverton.ibm.com>
	<20040719200608.280d17a1@lembas.zaitcev.lan>
	<20040720051353.GD313@ucw.cz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004 07:13:53 +0200
Vojtech Pavlik <vojtech@suse.cz> wrote:

> Actually USB Legacy SMM emulation triggers problems on many many more
> systems. The quirk does exactly the same thing the USB HCI drivers do in
> their init code, it only does it early in the boot process, so that
> even if the USB drivers are modules, the i8042 controller and PS/2 mouse
> and keyboard initialization proceeds correctly.

I guessed it, but I hoped it wasn't "many more systems", but rather
"a few", so matching would made sense.

It would be comforting to know that we ran this in 2.6 or elsewhere
before recommending it for Marcelo. Did you guys actually ship it
with SLES or something? For how long?

-- Pete
