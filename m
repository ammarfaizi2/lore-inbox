Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbSL0XoZ>; Fri, 27 Dec 2002 18:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbSL0XoZ>; Fri, 27 Dec 2002 18:44:25 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:4101 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S265243AbSL0XoY>;
	Fri, 27 Dec 2002 18:44:24 -0500
Date: Fri, 27 Dec 2002 15:48:56 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: Harald Dunkel <harri@synopsys.COM>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.53
Message-ID: <20021227234856.GB4025@net-ronin.org>
References: <Pine.LNX.4.44.0212232141010.1079-100000@penguin.transmeta.com> <3E0CCFFD.5090007@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E0CCFFD.5090007@Synopsys.COM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 11:11:09PM +0100, Harald Dunkel wrote:
> : undefined reference to `input_register_handler'
> make: *** [vmlinux] Error 1
> 
> 
> Is this a known problem?

Under Input Device Support, enable Input Devices.
CONFIG_INPUT=y

(Yup, that bit me, too.  Apparently, you can enable mouse and keyboard
support w/o enabling CONFIG_INPUT.  *shrug*)

-- DN
Daniel
