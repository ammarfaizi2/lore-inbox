Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbUHRGeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbUHRGeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268668AbUHRGeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:34:37 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:29300 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268664AbUHRGe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 02:34:28 -0400
Message-ID: <2a4f155d040817233463d2b78d@mail.gmail.com>
Date: Wed, 18 Aug 2004 09:34:25 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Olaf Hering <olh@suse.de>
Subject: Re: 2.6.8.1-mm1 Tty problems?
Cc: Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040818062210.GB22332@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2a4f155d040817070854931025@mail.gmail.com> <412247FF.5040301@microgate.com> <2a4f155d0408171116688a87f1@mail.gmail.com> <4122501B.7000106@microgate.com> <2a4f155d04081712005fdcdd9b@mail.gmail.com> <41225D16.2050702@microgate.com> <2a4f155d040817124335766947@mail.gmail.com> <41226512.9000405@microgate.com> <20040818062210.GB22332@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 08:22:10 +0200, Olaf Hering <olh@suse.de> wrote: 
> /dev/tty is supposed to be char c 5 0, /class/tty/tty/dev will tell udev
> how to create it, see man 4 tty.
> No idea who came up with the bright idea to put legacy bsd devices in a
> subdir. Documentation/devices.txt shows that my patch is ok, it handles
> up to 256 device nodes.
> If you are using udev, file a bugreport for your distros package. In the
> meantime, remove the offending line from your udev.rules file.

I don't think you understood me. /dev/tty is created as a char device
in 2.6.8.1 kernel. So I am sure udev is fine but it shows up as a
directory in 2.6.8.1-mm1 kernel and if I backup bk-driver-core.patch
its all normal again.

Cheers,
ismail


-- 
Time is what you make of it
