Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbUDEQXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 12:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUDEQXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 12:23:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:42465 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262917AbUDEQXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 12:23:20 -0400
Date: Mon, 5 Apr 2004 09:19:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Tony A. Lambley" <tal@vextech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [usbfs] 2.6.3+ devmode?
Message-Id: <20040405091933.3295744a.rddunlap@osdl.org>
In-Reply-To: <1081096740.2235.6.camel@bony>
References: <1081096740.2235.6.camel@bony>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Apr 2004 12:39:00 -0400 Tony A. Lambley wrote:

| Hi, is my brain going yolky? I have perm problems with a scanner after
| each boot, and have to manually locate the scanner in /proc/bus/usb then
| chmod it.
| 
| My fstab has:
| 
| none /proc/bus/usb usbfs defaults,devmode=0666 0 0
| 
| It happens with 2.6.3 through to .5. Am I doing something wrong or is
| usbfs+devmode a bit under the weather?

I think that's related to kernel bug #1418:
  http://bugme.osdl.org/show_bug.cgi?id=1418

| Or maybe I shouldn't be using usbfs? Is it being depreciated?

No, it's not being deprecated.

--
~Randy
