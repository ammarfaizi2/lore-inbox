Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUKSDrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUKSDrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 22:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUKSDrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 22:47:22 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:55494 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261236AbUKSDrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 22:47:18 -0500
Message-ID: <419D6CC3.4030308@verizon.net>
Date: Thu, 18 Nov 2004 22:47:15 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Falk <efalk@google.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE ioctl documentation & a new ioctl
References: <419D5CE6.8030503@google.com>
In-Reply-To: <419D5CE6.8030503@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.220.243] at Thu, 18 Nov 2004 21:47:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Falk wrote:
> Hi all; let me introduce myself:  I'm the guy that does IDE sustaining 
> for Google.
> 
> I'm getting ready to sit down and document the IDE ioctls.  Probably 
> Documentation/hdio.txt or something like that.  Before I start though, 
> is anybody already doing this?
> 

No one that I know of.  I had a thought in the back of my head of tackling ioctl 
documentation after I went through the stuff that's already in Documentation, but 
I figured I had enough to chew on for right now.

I'd probably make a subdirectory - i. e. Documentation/ioctl/hdio.txt - to 
differentiate it from other documents, and make it easier to get maintainers to 
put some stuff in there. ;)   AFAICT, there is next to no documentation on ioctl's 
anywhere in the kernel tarball.

> And while I'm on the subject, we're getting ready to write a new hdio 
> ioctl, an extension of HDIO_DRIVE_CMD.  The intent here is to be 
> slightly more general-purpose than HDIO_DRIVE_CMD, with an eye to 
> supporting the full set of SMART functionality.  Current plan is to have 
> the user pass a struct containing a pointer to the argument list, a 
> pointer to the data buffer, and a data buffer length value.  Consider 
> this a design document; any comments and/or feature requests?
> 
>     -ed falk
>     efalk@google.com
> -
