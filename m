Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbSKPGM2>; Sat, 16 Nov 2002 01:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbSKPGM2>; Sat, 16 Nov 2002 01:12:28 -0500
Received: from holomorphy.com ([66.224.33.161]:48083 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267227AbSKPGM1>;
	Sat, 16 Nov 2002 01:12:27 -0500
Date: Fri, 15 Nov 2002 22:15:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Patrick Finnegan <pat@purdueriots.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Dan Kegel <dank@kegel.com>,
       john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
Message-ID: <20021116061534.GE23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Patrick Finnegan <pat@purdueriots.com>,
	Jeff Garzik <jgarzik@pobox.com>, Dan Kegel <dank@kegel.com>,
	john slee <indigoid@higherplane.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DD5DC77.2010406@pobox.com> <Pine.LNX.4.44.0211160059540.16668-100000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211160059540.16668-100000@ibm-ps850.purdueriots.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2002, Jeff Garzik wrote:
>> If people want to get rivafb or an ancient ISA net driver building
>> again... patches welcome.  But I don't think calls for the kernel to
>> compile 100 percent of the drivers is realistic or even reasonable.
>> Some of the APIs, particularly SCSI, are undergoing API stabilization.
[snip]

On Sat, Nov 16, 2002 at 01:04:35AM -0500, Patrick Finnegan wrote:
> Wouldn't it then seem reasonable to remove things from the kernel that
> have been broken for a long time, and no one seems to care enough to fix?
> I know of at least one driver (IOmega Buz v4l) that seems to have fallen
> into disrepair possibly since before 2.4.0, and as far as I know has not
> been repaired since then.

A lot of driver writers probably aren't going to even start updating
until the stable release is released. IIRC there are many vendors etc.
who focus exclusively on stable kernel releases, and who will let their
code (e.g. drivers) bitrot the entire way through the development cycle.

And there is plenty of code that is being updated now for the first
time since 2.0.x, and some arches that haven't merged since before 2.4.0

Bill
