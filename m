Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266254AbUG0Gac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUG0Gac (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 02:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUG0Gab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 02:30:31 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:772 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266254AbUG0Gaa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 02:30:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org
Subject: Re: Wireless devices and route settings
Date: Tue, 27 Jul 2004 09:29:57 +0300
X-Mailer: KMail [version 1.4]
References: <pan.2004.07.27.05.34.35.543474@triplehelix.org>
In-Reply-To: <pan.2004.07.27.05.34.35.543474@triplehelix.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200407270929.57779.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 08:34, Joshua Kwan wrote:
> Hello,
>
> So, I have a wireless interface on a 'guest' Linux box (running 2.6.7-rc1,
> not bothered to compile a new kernel yet.) It is a fair distance away from
> the access point and sometimes goes out of range.
>
> Usually it can go out of range and come back in range without the user
> noticing anything has happened. But once in a while, when the connection
> is especially poor, the interface will go down and lose its default route.

What do you mean "interface will go down"? Down is an administrative state,
settable only by admin (ifconfig up/down or equivalent).
If your wireless device driver does that all by itself, it is buggy.

Elaborate on "interface will go down". Provide 
ifconfig, routing and iwconfig data before and
after the event.

> When it comes back, it retains its IP, but does not keep the default route.
> This makes the internet unusable on this machine until i cycle ifdown/ifup
> which I cannot rely on guests to do.
>
> There is no daemon watching the network interfaces at all that might be
> doing this (I'm pretty sure), so I was hoping linux-kernel might know.
>
> Here's to a prompt solution..

-- 
vda
