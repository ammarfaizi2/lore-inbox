Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbTCYQQw>; Tue, 25 Mar 2003 11:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262721AbTCYQQv>; Tue, 25 Mar 2003 11:16:51 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262719AbTCYQQv>;
	Tue, 25 Mar 2003 11:16:51 -0500
Date: Tue, 25 Mar 2003 08:23:57 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: PATCH: newer boards put other hw at rtc + 0x08
Message-Id: <20030325082357.78bb702d.rddunlap@osdl.org>
In-Reply-To: <20030325091153.GA32193@f00f.org>
References: <200303211924.h2LJObKX025741@hraefn.swansea.linux.org.uk>
	<20030325091153.GA32193@f00f.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003 01:11:53 -0800 Chris Wedgwood <cw@f00f.org> wrote:

| On Fri, Mar 21, 2003 at 07:24:37PM +0000, Alan Cox wrote:
| 
| > -#define RTC_IO_EXTENT 0x10 /* Only really two ports, but... */
| > +#define RTC_IO_EXTENT 0x8
| 
| If the comment was/is correct then was not 0x2?

The comment is only partially correct, depending on how the device
is used.  It can be used in modes that use 8 ports.

--
~Randy
