Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268011AbTBYQSD>; Tue, 25 Feb 2003 11:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268020AbTBYQSD>; Tue, 25 Feb 2003 11:18:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:27551 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268011AbTBYQSC>;
	Tue, 25 Feb 2003 11:18:02 -0500
Date: Tue, 25 Feb 2003 08:23:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: mikael.starvik@axis.com, linux-kernel@vger.kernel.org,
       tinglett@vnet.ibm.com, torvalds@transmeta.com
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-Id: <20030225082349.6ae09dc4.rddunlap@osdl.org>
In-Reply-To: <20030225092520.A9257@flint.arm.linux.org.uk>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se>
	<20030225092520.A9257@flint.arm.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003 09:25:20 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

| On Tue, Feb 25, 2003 at 07:28:46AM +0100, Mikael Starvik wrote:
| > >I don't know linker scripts very well.
| > >Can this be done for all architectures?
| > >I'd like to see a solution that is arch-independent.
| > 
| > In embedded systems it is probably not desirable to keep 
| > System.map and config in zImage (takes too much valuable space).
| 
| Agreed - zImage is already around 1MB on many ARM machines, and since
| loading zImage over a serial port using xmodem takes long enough
| already, this is one silly feature I'll definitely keep out of the
| ARM tree.

Yes, I understand that.  I would want it to be a config option.

--
~Randy
