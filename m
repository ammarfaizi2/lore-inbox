Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318744AbSHLRCa>; Mon, 12 Aug 2002 13:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318747AbSHLRC3>; Mon, 12 Aug 2002 13:02:29 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:58894 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318744AbSHLRC3>;
	Mon, 12 Aug 2002 13:02:29 -0400
Date: Mon, 12 Aug 2002 10:02:33 -0700
From: Greg KH <greg@kroah.com>
To: David Fries <dfries@mail.win.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via vp3 udma corruption
Message-ID: <20020812170232.GC15249@kroah.com>
References: <20020811210826.GA684@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020811210826.GA684@spacedout.fries.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 15 Jul 2002 14:49:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 04:08:26PM -0500, David Fries wrote:
> 
> I did most of my testing with 2.4.17 since my USB mouse doesn't work
> with 2.4.19 but does with 2.4.17.

Make sure CONFIG_USB_HIDINPUT is enabled.  You _did_ run 
'make oldconfig' with your old 2.4.17 .config file, right?

thanks,

greg k-h
