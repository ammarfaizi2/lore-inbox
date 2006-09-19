Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWISChH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWISChH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 22:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWISChG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 22:37:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34448 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750957AbWISChF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 22:37:05 -0400
Date: Mon, 18 Sep 2006 19:36:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: tarka@internode.on.net (Steve Smith)
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>
Subject: Re: Repeatable hang on boot with PCMCIA card present
Message-Id: <20060918193648.12cf11de.akpm@osdl.org>
In-Reply-To: <20060919022541.GA25830@lucretia.remote.isay.com.au>
References: <20060916050331.GA6685@lucretia.remote.isay.com.au>
	<20060918190902.d5b6a698.akpm@osdl.org>
	<20060919022541.GA25830@lucretia.remote.isay.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 12:25:41 +1000
tarka@internode.on.net (Steve Smith) wrote:

> On Mon, Sep 18, 2006 at 07:09:02PM -0700, Andrew Morton wrote:
> > Damn, that was a huge patch.  Have you been able to grab
> > a copy of the oops output?  It would really help.  Even a photo of
> > the screen..
> 
> No oops I'm afraid, just the hang and EIP message.  The numbers
> with the message change each time but I can send them when I get to
> the machine later.

hm, ugly.

>  Is there another way to coax more information out
> of the kernel?

I don't expect so - if it doesn't print anything useful to the console
we're rather stuck.  You probably don't have a serial port.  If you have a
lan port then netconsole _might_ work, but I'd say it's unlikely.

Dunno.  You _might_ be able to get a better trace by changing settings such
as CONFIG_FRAME_POINTER, CONFIG_4KSTACKS, CONFIG_UNWIND_INFO, and
CONFIG_DEBUG_*.
