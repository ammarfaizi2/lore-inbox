Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUIUK55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUIUK55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 06:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbUIUK55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 06:57:57 -0400
Received: from holomorphy.com ([207.189.100.168]:57285 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267554AbUIUK54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 06:57:56 -0400
Date: Tue, 21 Sep 2004 03:57:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or directory)?
Message-ID: <20040921105745.GJ9106@holomorphy.com>
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58517.194.237.142.24.1095763849.squirrel@194.237.142.24>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Dan Kegel wrote:
>> I'm trying to verify that I can build toolchains and compile
>> and link kernels for a large set of CPU types using simple kernel config
>> files.
>> I'm also somewhat foolishly trying to do all this with gcc-3.4.2.
>> So any problems I run into are a bit hard to pin down to
>> compiler, kernel, or user error, since this is mostly new territory for
>> me.
>> Here's another issue.
>> When I build 2.6.8 for sparc32, using the config file
>> http://kegel.com/crosstool/crosstool-0.28-rc36/sparc.config ,
>> I get a link error:

On Tue, Sep 21, 2004 at 12:50:49PM +0200, Sam Ravnborg wrote:
> Look like arch/sparc/boot/Makefile is too old.
> vmlinux.lds.s were renamed to vmlinux.lds 2004/08/15 - maybe you need to
> checkout that file?

I don't see this kind of issue in current 2.6.x; what's going on?


-- wli
