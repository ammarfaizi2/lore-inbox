Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTLRTIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbTLRTIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:08:24 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:27339 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265261AbTLRTIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:08:23 -0500
Date: Thu, 18 Dec 2003 11:08:09 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Arnaud Fontaine <dsdebian@free.fr>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.23
Message-ID: <20031218190809.GB6438@matchmail.com>
Mail-Followup-To: Arnaud Fontaine <dsdebian@free.fr>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20031218085621.GA8283@scrappy> <Pine.LNX.4.44.0312180946550.4547-100000@logos.cnet> <20031218130601.GA11274@scrappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218130601.GA11274@scrappy>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 02:06:01PM +0100, Arnaud Fontaine wrote:
> On Thu, Dec 18, 2003 at 09:47:42AM -0200, Marcelo Tosatti wrote:
> > 
> > Andrew, 
> > 
> > This is likely to be bad memory.
> > 
> > Can you try memtest86 on the box ? 
> 
> Hello,
> 
> Before install Debian GNU/Linux Woody on this box, i have ran memtest
> with a bootable media and have no error after 13 pass. But i have added
> memory after. It comes from an other PC running perfectly with this. So
> i think it could come from the memory but if you want i can launch
> memtest again this night ;).

There is a difference between memtest and memtest86.  memtest86 tests all of
your memory, and memtest can only test the userspace memory it can lock.
