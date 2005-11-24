Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbVKXUXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbVKXUXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVKXUXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:23:08 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:59616 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751398AbVKXUXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:23:06 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Date: Thu, 24 Nov 2005 21:23:59 +0100
User-Agent: KMail/1.8.3
Cc: Ed Tomlinson <tomlins@cam.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <200511240717.11752.tomlins@cam.org> <20051124124444.GA23667@stiffy.osknowledge.org>
In-Reply-To: <20051124124444.GA23667@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511242124.00127.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24 of November 2005 13:44, Marc Koschewski wrote:
}-- snip --{
> > It looks like you are seeing a different bug.  The one opened for debian user space
> > covers mousedev not being loaded if the kernel is 2.6.15, which leads to no /dev/input
> > 
> 
> That's what I think, thus the report on LKLM. But noone but me seems to
> be trapped into it until... :/

FWIW, my touchpad doesn't work with -rc2-mm1 too (usually I use a USB mouse,
so I didn't notice before).  Here's what dmesg says about it:

Synaptics Touchpad, model: 1, fw: 5.9, id: 0x926eb1, caps: 0x804719/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input2

The box is an Asus L5D (x86-64).

Greetings,
Rafael
