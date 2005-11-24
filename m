Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVKXVT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVKXVT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 16:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbVKXVT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 16:19:29 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:12001 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932300AbVKXVT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 16:19:28 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Date: Thu, 24 Nov 2005 22:20:25 +0100
User-Agent: KMail/1.8.3
Cc: Marc Koschewski <marc@osknowledge.org>, Ed Tomlinson <tomlins@cam.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <20051124124444.GA23667@stiffy.osknowledge.org> <200511242124.00127.rjw@sisk.pl>
In-Reply-To: <200511242124.00127.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511242220.25702.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update:

On Thursday, 24 of November 2005 21:23, Rafael J. Wysocki wrote:
> On Thursday, 24 of November 2005 13:44, Marc Koschewski wrote:
> }-- snip --{
> > > It looks like you are seeing a different bug.  The one opened for debian user space
> > > covers mousedev not being loaded if the kernel is 2.6.15, which leads to no /dev/input
> > > 
> > 
> > That's what I think, thus the report on LKLM. But noone but me seems to
> > be trapped into it until... :/
> 
> FWIW, my touchpad doesn't work with -rc2-mm1 too (usually I use a USB mouse,
> so I didn't notice before).  Here's what dmesg says about it:
> 
> Synaptics Touchpad, model: 1, fw: 5.9, id: 0x926eb1, caps: 0x804719/0x0
> input: SynPS/2 Synaptics TouchPad as /class/input/input2
> 
> The box is an Asus L5D (x86-64).

Actually, it works on the console (ie with gpm), but X is unable to use it,
apparently.  However it used to be, at least on 2.6.14-git9 (this is the latest
non-mm kernel I've been able to test quickly on this box).

Marc, does your touchpad work with gpm?

Rafael
