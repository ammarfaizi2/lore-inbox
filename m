Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVIFV1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVIFV1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVIFV1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:27:24 -0400
Received: from [202.65.75.150] ([202.65.75.150]:37573 "EHLO
	pythia.bakeyournoodle.com") by vger.kernel.org with ESMTP
	id S1750860AbVIFV1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:27:23 -0400
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 7 Sep 2005 07:27:01 +1000
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: wakeup on lan enable without compiling as module
Message-ID: <20050906212701.GY1830@bakeyournoodle.com>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050906185338.GJ26445@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906185338.GJ26445@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 08:53:38PM +0200, Thomas Glanzmann wrote:
> Hello,
> I would like to build the 3c59x vortex module into the kernel (not as
> module) but don't loose the ability to use wakeup-on-lan. Because it
> seems to be impossible to specify 'module parameters' to a built-in
> kernel module I tried the following patch, which doesn't work for me.
> Could someone enlighten me how I can get the expected behaviour?

IIRC you can pass "module parameters" to code built into the kernel on the
kernel command line.  I /think/ the form is
${module_name}_${module_arg}=....

So no need to modify the code.

Yours Tony

   linux.conf.au       http://linux.conf.au/ || http://lca2006.linux.org.au/
   Jan 23-28 2006      The Australian Linux Technical Conference!

