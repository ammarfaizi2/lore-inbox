Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWFSQqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWFSQqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWFSQqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:46:14 -0400
Received: from adsl-71-128-175-242.dsl.pltn13.pacbell.net ([71.128.175.242]:16583
	"EHLO build.embeddedalley.com") by vger.kernel.org with ESMTP
	id S932525AbWFSQqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:46:13 -0400
Subject: Re: i2c-algo-ite and i2c-ite planned for removal
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060616222908.f96e3691.khali@linux-fr.org>
References: <20060615225723.012c82be.khali@linux-fr.org>
	 <1150406598.1193.73.camel@localhost.localdomain>
	 <20060616222908.f96e3691.khali@linux-fr.org>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date: Mon, 19 Jun 2006 19:45:58 +0300
Message-Id: <1150735558.8413.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-16 at 22:29 +0200, Jean Delvare wrote:
> Hi Pete,
> 
> > > So basically we have two drivers in the kernel tree for 5 years or so,
> > > which never were usable, and nobody seemed to care. 
> > 
> > For historical correctness, this driver was once upon a time usable,
> > though it was a few years ago. It was written by MV for some ref board
> > that had the ITE chip and it did work. That ref board is no longer
> > around so it's probably safe to nuke the driver. 
> 
> In which kernel version? In every version I checked (2.4.12, 2.4.30,
> 2.6.0 and 2.6.16) it wouldn't compile due to struct iic_ite being used
> but never defined (and possibly other errors, but I can't test-compile
> the driver.)

Honestly, I don't remember. I think it was one of the very first 2.6
kernels because when MV first released a 2.6 product, 2.6 was still
'experimental'. It's quite possible of course that the driver was never
properly merged upstream in the community tree(s). But I do know that it
worked in the internal MV tree and an effort was made to get the driver
accepted upstream.

Pete

