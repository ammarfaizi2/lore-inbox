Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278603AbRJSS7Y>; Fri, 19 Oct 2001 14:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278604AbRJSS7P>; Fri, 19 Oct 2001 14:59:15 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:48107 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278603AbRJSS7B>; Fri, 19 Oct 2001 14:59:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Fri, 19 Oct 2001 21:02:09 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0110191108590.17647-100000@osdlab.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33.0110191108590.17647-100000@osdlab.pdx.osdl.net>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15uerh-0NbBEeC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 October 2001 20:26, Patrick Mochel wrote:
> There are equivalents in USB. But, neither of them are globally unique
> identifiers for the device. That doesn't necessarily mean that one
> couldn't be ascertained from the device; ethernet cards do have MAC
> addresses. But, I don't think that many will have a ID/serial number.
> [...]
> Which leads me to the question: what real benefit does this have? Why
> would you ever want to do a global search in kernel space for a particular
> device? 

For example for harddisks. You usually want them to be mounted in the same 
directory. Or if you have several printers of the same type connected your 
computer you need a way of identifying them. Or for ethernet adapters: 
because each is connected to a different network, so you need to assign 
different IP addresses to them.

Actually most USB harddisks, printers and network adapters have unique serial 
number (you have to be careful though as some claim to have a serial number, 
but it is not unique).

bye...
