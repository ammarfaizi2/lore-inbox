Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUACENy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 23:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbUACENy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 23:13:54 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:3592 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262566AbUACENx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 23:13:53 -0500
Date: Sat, 3 Jan 2004 04:00:13 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rob Love <rml@ximian.com>, Andries Brouwer <aebr@win.tue.nl>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040103040013.A3100@pclin040.win.tue.nl>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl> <1072917113.11003.34.camel@fur> <200401010634.28559.rob@landley.net> <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl> <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401021238510.5282@home.osdl.org>; from torvalds@osdl.org on Fri, Jan 02, 2004 at 12:42:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 12:42:41PM -0800, Linus Torvalds wrote:

Hi Linus - A happy 2004 !


> Note that one reason I didn't much like the 64-bit versions is that not 
> only are they bigger, they also encourage insanity. Ie you'd find SCSI 
> people who want to try to encode device/controller/bus/target/lun info 
> into the device number. 

Weak. "We don't want this power that has good uses because it also
can be used stupidly." That is not Unix-style.

> We should resist any effort that makes the numbers "mean" something. They 
> are random cookies. Not "unique identifiers", and not "addresses".

Random cookies? I prefer "arbitrary" over "random". The value plays no role
at all, but it must be unique, preferably stable across reboots.

Andries



