Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTDHP2O (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbTDHP2O (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:28:14 -0400
Received: from tomts19.bellnexxia.net ([209.226.175.73]:30690 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261845AbTDHP2N (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 11:28:13 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.5.67-mm1
Date: Tue, 8 Apr 2003 11:39:58 -0400
User-Agent: KMail/1.5.9
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030408042239.053e1d23.akpm@digeo.com> <200304080917.15648.tomlins@cam.org> <20030408083153.5dec0d0e.rddunlap@osdl.org>
In-Reply-To: <20030408083153.5dec0d0e.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304081139.58218.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On April 8, 2003 11:31 am, Randy.Dunlap wrote:
> On Tue, 8 Apr 2003 09:17:15 -0400 Ed Tomlinson <tomlins@cam.org> wrote:
> | Hi,
> |
> | This does not boot here.  I loop with the following message.
> |
> | i8042.c: Can't get irq 12 for AUX, unregistering the port.
> |
> | irq 12 is used (correctly) by my 20267 ide card.  My mouse is
> | usb and AUX is not used.
> |
> | Ideas?
>
> I guess that's due to my early kbd init patch.
> So why do you have i8042 configured into your kernel?

One, What exactly configures it?  Two my keyboard is not usb, just
my mouse.

> The loop doesn't terminate?  Do you get the same message (above)
> over and over again?

Yes, until I trigger a reboot (SysReq+B).

Ed


