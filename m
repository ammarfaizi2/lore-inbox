Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264547AbSIQWKg>; Tue, 17 Sep 2002 18:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264557AbSIQWKg>; Tue, 17 Sep 2002 18:10:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23561 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264547AbSIQWKf>;
	Tue, 17 Sep 2002 18:10:35 -0400
Date: Tue, 17 Sep 2002 15:12:18 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Thomas Dodd <ted@cypress.com>
cc: Rogier Wolff <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>,
       <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] Re: Problems accessing USB Mass Storage
In-Reply-To: <3D87A6E3.5090407@cypress.com>
Message-ID: <Pine.LNX.4.33L2.0209171510550.14033-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2002, Thomas Dodd wrote:

|
|
| Rogier Wolff wrote:
| > On Tue, Sep 17, 2002 at 10:46:31AM -0700, Greg KH wrote:
| >
| >>On Tue, Sep 17, 2002 at 12:37:37PM -0500, Thomas Dodd wrote:
| >>
| >>>I get the feeling it's not a true mass storage device.
| >>
| >>Sounds like it.
| >
| >
| > Nope. Sure does sound like it's a mass storage device. And it works
| > too.
| >
| > The kernel managed to read the partition table off it, and got
| > one valid partition: sda1.
|
| Accept that you cannot read data from the device. At all.
| Even dd fails. And the windows drivers work (using XP
| in vmware it think it was) correctly on this same device.

Really?  Rogier's 'seek.c' program looks quite feasible to me.
'dd' wasn't seeking beyond sectors, it was trying to read &
discard them.

-- 
~Randy
"Linux is not a research project. Never was, never will be."
  -- Linus, 2002-09-02

