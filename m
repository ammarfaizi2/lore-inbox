Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUH1FT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUH1FT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 01:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUH1FT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 01:19:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:36803 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268177AbUH1FTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 01:19:54 -0400
Date: Fri, 27 Aug 2004 22:19:19 -0700
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: steve@steve-parker.org, linux-kernel@vger.kernel.org
Subject: Re: PWC issue
Message-ID: <20040828051919.GC10151@kroah.com>
References: <200408281750.i7SHo5C05936@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408281750.i7SHo5C05936@freya.yggdrasil.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 10:50:05AM -0700, Adam J. Richter wrote:
> 
> 	By the way, I have a long running dispute with Greg K-H
> about his refusal so far to remove replace the GPL incompatible
> firmware in certain USB serial drivers with such a user level
> loading mechanism.  Go figure.

Send me a patch to do so, and I will apply it (must include userspace
files so that hotplug can load them properly.)

The last time we went around about this I rejected it as we were in a
stable kernel series.  As that is now not true, I'm open to the patch.

It's not an idealogical issue for me, given Linus's statements about
firmware in the kernel, but I do agree that it is a better thing as we
have used up less kernel memory.

thanks,

greg k-h
