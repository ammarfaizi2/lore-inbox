Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSJQJEe>; Thu, 17 Oct 2002 05:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSJQJEe>; Thu, 17 Oct 2002 05:04:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30844 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261205AbSJQJEd>; Thu, 17 Oct 2002 05:04:33 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org, mochel@osdl.org,
       rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210170150.SAA06074@adam.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Oct 2002 03:08:47 -0600
In-Reply-To: <200210170150.SAA06074@adam.yggdrasil.com>
Message-ID: <m165w1300w.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

After having looked at it, device_shutdown is correct enough and
close enough to what I need, that I no longer care about the exact details.
Just so long as sys_reboot calls always calls it, and kexec can call it.

If you can talk someone into improving it's implementation that is fine
with me.  As I find drivers that are causing problems problems because they
won't shut up I will point the driver authors in the direction of whatever
the current kernel api is.

Eric
