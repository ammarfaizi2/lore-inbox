Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTDHWSQ (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTDHWSQ (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:18:16 -0400
Received: from granite.he.net ([216.218.226.66]:17678 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261977AbTDHWSL (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:18:11 -0400
Date: Tue, 8 Apr 2003 15:25:47 -0700
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] : Linux 2.5.67
Message-ID: <20030408222547.GA6747@kroah.com>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com> <20030408003625.51a788a0.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408003625.51a788a0.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 12:36:25AM +0200, Udo A. Steinberg wrote:
> On Mon, 7 Apr 2003 10:53:43 -0700 (PDT) Linus Torvalds (LT) wrote:
> 
> LT> v2.5.67
> 
> Hello,
> 
> Below is the backtrace of a USB oops which has has been freezing my system
> since around 2.5.65 and which I've only just spotted. I have a monitor with
> built-in USB hub. When the monitor is turned off, the USB hub disconnects from
> its upstream hub and when the monitor is turned on again, the hub reconnects.
> I can't tell if the oops happens on disconnect or reconnect though. I don't
> have a serial cable atm, but I hope the information is sufficient. If not,
> please let me know. Or you can send me a patch to try out.

There's a patch in the archives, and in the -mm tree that fixes this
oops for now.  But it's not the correct fix, and I'm working on finding
out the root cause of this problem.

Let me know if you can't find the patch and I'll dig it up.

thanks,

greg k-h
