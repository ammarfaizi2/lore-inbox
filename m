Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUGMUTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUGMUTR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265806AbUGMUTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:19:17 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:33671 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S265805AbUGMUTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:19:15 -0400
Date: Tue, 13 Jul 2004 22:19:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Maikon Bueno <maikon@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse driver
Message-ID: <20040713201936.GA3124@ucw.cz>
References: <757c55c6040712065266e867e5@mail.gmail.com> <20040712172844.GA2375@prot.minidns.net> <757c55c6040713071814ff655c@mail.gmail.com> <757c55c604071312106d515d78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757c55c604071312106d515d78@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 04:10:09PM -0300, Maikon Bueno wrote:
> Hi all...
> I'm developing a serial mouse driver and I would like to know how can
> I do to associate a driver with the device.
> To do this driver code I followed a tutorial by Alan Cox. I used the
> register_chrdev function to associate the driver with the device,
> however when I issue "cat /dev/mymouse" (the mymouse device was
> created using the "mknod" command with the same major number of the
> driver and the module is already loaded), I got a error message.
> Is there any way of to do this?
> When are the open_mouse and ourmouse_interrupt functions called?
> 
> Thanks!!

I think you should take a look at
	
	Documentation/input/input-programming.txt

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
