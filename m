Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTKYRP1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTKYRP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:15:27 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:29094 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S262772AbTKYRPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:15:23 -0500
Message-ID: <3FC38E26.9080602@backtobasicsmgmt.com>
Date: Tue, 25 Nov 2003 10:15:18 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <thornber@sistina.com>
CC: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti> <3FC387A0.8010600@backtobasicsmgmt.com> <20031125170503.GG524@reti>
In-Reply-To: <20031125170503.GG524@reti>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:

> For the last few months the tools have supported both v1 and v4
> interfaces, allowing people to roll back to older kernels.  I will
> update the Kconfig help as you suggest to be more specific about the
> tool versions.

My biggest concern here is that even if someone downloads the latest 
device-mapper tools tarball and compiles it on their system, unless they 
specifically point it at 2.6 kernel headers it won't compile in v4 ioctl 
support, so they could be unpleasantly surprised. Given the prevailing 
sentiment about _not_ updating /usr/include/{linux,asm} to the headers 
with a newly-installed kernel (but rather leaving them the same versions 
that libc was compiled against) this a pretty likely scenario unless I'm 
mistaken...

