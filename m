Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbUCOMxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 07:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbUCOMxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 07:53:13 -0500
Received: from prosun.first.gmd.de ([194.95.168.2]:55955 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262550AbUCOMxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 07:53:11 -0500
Subject: Re: 2.6.4 - powerbook 15" - usb oops+backtrace
From: Soeren Sonnenburg <kernel@nn7.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040315122127.GA776@ucw.cz>
References: <1079097936.1837.102.camel@localhost>
	 <20040313121027.GA7434@ucw.cz> <1079349195.1721.14.camel@localhost>
	 <20040315122127.GA776@ucw.cz>
Content-Type: text/plain
Message-Id: <1079355182.1688.115.camel@localhost>
Mime-Version: 1.0
Date: Mon, 15 Mar 2004 13:53:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-15 at 13:21, Vojtech Pavlik wrote:
> On Mon, Mar 15, 2004 at 12:13:16PM +0100, Soeren Sonnenburg wrote:
[...]
> > So could this be pbbuttonsd's fault :? or is it indeed some kernel bug ?
> 
> It's a kernel bug, definitely. And it's interesting to know that it
> happens on device _removal_, that means HID could be freeing the device
> structs earlier than evdev is stopping to use them.

It does not happen with 2.6.3-ben2 if that helps...

Soeren

