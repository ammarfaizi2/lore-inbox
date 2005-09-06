Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVIFVdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVIFVdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVIFVdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:33:16 -0400
Received: from xenotime.net ([66.160.160.81]:5783 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750818AbVIFVdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:33:16 -0400
Date: Tue, 6 Sep 2005 14:33:15 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Tony Breeds <tony@bakeyournoodle.com>
cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: wakeup on lan enable without compiling as module
In-Reply-To: <20050906212701.GY1830@bakeyournoodle.com>
Message-ID: <Pine.LNX.4.50.0509061432271.19596-100000@shark.he.net>
References: <20050906185338.GJ26445@cip.informatik.uni-erlangen.de>
 <20050906212701.GY1830@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2005, Tony Breeds wrote:

> On Tue, Sep 06, 2005 at 08:53:38PM +0200, Thomas Glanzmann wrote:
> > Hello,
> > I would like to build the 3c59x vortex module into the kernel (not as
> > module) but don't loose the ability to use wakeup-on-lan. Because it
> > seems to be impossible to specify 'module parameters' to a built-in
> > kernel module I tried the following patch, which doesn't work for me.
> > Could someone enlighten me how I can get the expected behaviour?
>
> IIRC you can pass "module parameters" to code built into the kernel on the
> kernel command line.  I /think/ the form is
> ${module_name}_${module_arg}=....
                . here instead of _

It's documented in Documentation/kernel-parameters.txt .

> So no need to modify the code.

-- 
~Randy
