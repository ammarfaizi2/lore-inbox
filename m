Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbTIEUIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTIEUIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:08:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27153
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262724AbTIEUIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:08:40 -0400
Date: Fri, 5 Sep 2003 13:08:44 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: James Clark <jimwclark@ntlworld.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Message-ID: <20030905200844.GB19041@matchmail.com>
Mail-Followup-To: James Clark <jimwclark@ntlworld.com>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <1062637356.846.3471.camel@cube> <200309042251.38514.jimwclark@ntlworld.com> <200309051752.h85HqYS0031240@turing-police.cc.vt.edu> <200309051931.09491.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309051931.09491.jimwclark@ntlworld.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 07:31:09PM +0100, James Clark wrote:
> This is not about Windows v Linux so please stop compraring what I have 
> proposed to Windows. This debate should be about Performance v Usability. 
> Source interfaces have ultimate performance, nobody has suggested, yet, that 
> they are easier for Joe User than a binary interface.

Here is one thing we don't have standardized across the entire Linux
distribution landscape.

What you need is a project that will take the top 10 distributions, and do
this however each distribution does their thing:

 o identify the current kernel running (you're going to use the kernel
   you're running, right?)
  
 o download the kernel source for the running kernel

 o install the source in some temporary location

 o compile against the downloaded kernel source

 o install the module under /lib/modules

 o load the module (with the corect optional parameters)

Now what we need is someone to create the project, and get the community to
point to that project for source available external driver modules.

And look!  No kernel modifications!
