Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUFNXOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUFNXOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 19:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUFNXOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 19:14:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:62883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263324AbUFNXOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 19:14:16 -0400
Date: Mon, 14 Jun 2004 16:10:54 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tim Hockin <thockin@hockin.org>
Cc: cfriesen@nortelnetworks.com, bernd@firmix.at, oliver@neukum.org,
       smfltc@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: upcalls from kernel code to user space daemons
Message-Id: <20040614161054.1751506e.rddunlap@osdl.org>
In-Reply-To: <20040614225438.GA22161@hockin.org>
References: <1087250925.8828.3.camel@gimli.at.home>
	<40CE2538.4060603@nortelnetworks.com>
	<20040614225438.GA22161@hockin.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2004 15:54:38 -0700 Tim Hockin wrote:

| On Mon, Jun 14, 2004 at 06:22:48PM -0400, Chris Friesen wrote:
| > > > Not quite.  The userspace is passing data down as well.  I don't know 
| > >how you'd
| > > > do that with read().
| > >
| > >For this you use write().
| 
| > Although I have to admit it's not pretty, and the performance improvements 
| > may not be worth the obfuscation of the code.
| 
| You know, I've never understood why people hate ioctl.  Sometimes, it
| really is what you want.  Why impose structured data onto a 2-way
| unstructred system (read/write) when you have a structured system at hand
| (ioctl).
| 
| I like ioctl() when it makes sense.  read() and write() are for data.
| ioctl is for (tada!) control.
                ^^^^
Looks like data in nuxi format.

Anyway, I agree with you.

--
~Randy
