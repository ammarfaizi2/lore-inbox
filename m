Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261833AbTCaUhs>; Mon, 31 Mar 2003 15:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbTCaUhs>; Mon, 31 Mar 2003 15:37:48 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31926 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261833AbTCaUhr>;
	Mon, 31 Mar 2003 15:37:47 -0500
Date: Mon, 31 Mar 2003 12:44:40 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nicholas Wourms <nwourms@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] kmsgdump for 2.5.65/66
Message-Id: <20030331124440.3d9bc6bf.rddunlap@osdl.org>
In-Reply-To: <3E88942F.2090407@myrealbox.com>
References: <20030319141048.GA19361@suse.de>
	<20030320112559.A12732@namesys.com>
	<20030320132409.GA19042@suse.de>
	<20030320165941.0d19d09d.akpm@digeo.com>
	<20030320231335.GB4638@suse.de>
	<20030320153427.6265e864.rddunlap@osdl.org>
	<3E7CBB27.8090506@myrealbox.com>
	<20030331105341.72ec6b8a.rddunlap@osdl.org>
	<3E88942F.2090407@myrealbox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003 14:17:03 -0500 Nicholas Wourms <nwourms@myrealbox.com> wrote:

| Randy.Dunlap wrote:
| > 
| > so.....
| > 
| > kmsgdump for Linux 2.5.65/2.5.66
| > 2003-03-31
| > version 0.4.5
| 
| Thanks for porting this to 2.5.66!
| 
| [SNIP]
| 
| 
| > 2.  The kmsgdump text-mode interface doesn't work with a USB-only keyboard
| > setup.  I had to add a PS/2 keyboard to my test system to use it.
| 
| Hey, it's better then the alternative ;-).  I, too, use a 
| usb keyboard.  Perhaps some of the kdb usb code could be 
| ripped off?

Maybe.  I haven't looked at that code, although I am aware of kdb having it.
However, kmsgdump operates in real mode (currently), so this might need
to be real-mode USB drivers.  And then if a USB keyboard is supported,
someone will say, "how about supporting a USB floppy or USB printer?".  :(

--
~Randy
