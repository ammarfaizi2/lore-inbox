Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262547AbSJIXvv>; Wed, 9 Oct 2002 19:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbSJIXvv>; Wed, 9 Oct 2002 19:51:51 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:11276 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262547AbSJIXvt>;
	Wed, 9 Oct 2002 19:51:49 -0400
Date: Wed, 9 Oct 2002 16:53:32 -0700
From: Greg KH <greg@kroah.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] pl2303 oops in 2.4.20-pre10 (and 2.5 too)
Message-ID: <20021009235332.GA19351@kroah.com>
References: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 04:36:24PM -0700, Barry K. Nathan wrote:
> On one of my systems, when minicom opens /dev/ttyUSB0 (a PL2303) and
> the kernel is 2.4.20-pre10 (compiled with Mandrake 9's gcc 3.2),
> minicom segfaults and the kernel oopses.

Can you enable debugging in the pl2303 driver (by loading it with
"debug=1") and send the kernel debug log for when the oops happens.

thanks,

greg k-h
