Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTENPZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbTENPZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:25:00 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:52666 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S262571AbTENPY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:24:57 -0400
Date: Wed, 14 May 2003 17:36:35 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Ahmed Masud <masud@googgun.com>,
       walt <wa1ter@myrealbox.com>
Subject: Re: cannot boot 2.5.69
In-Reply-To: <20030514152255.GY10374@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0305141734020.1872-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> > > > > I still find no way to boot a 2.5.69 kernel.
> > > > > It reports: "no console found, specify init= option"

> What kind of console do you have configured in and what's your kernel
> command line?

It's a Dell laptop, nothing special.

This is the relevant part of my config:
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_LP_CONSOLE is not set
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

And the part of /boot/grub/grub.conf:
title Pau Linux (2.5.69)
        root (hd0,0)
        kernel /vmlinuz-2.5.69 ro root=/dev/hda1

Pau


