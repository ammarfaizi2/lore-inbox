Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWAPVoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWAPVoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWAPVoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:44:24 -0500
Received: from free.wgops.com ([69.51.116.66]:2821 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1750791AbWAPVoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:44:23 -0500
Date: Mon, 16 Jan 2006 14:44:08 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8 NFS not stateless and random failures?
Message-ID: <2D057F9AFB073ADB58A8E4FC@dhcp-2-206.wgops.com>
In-Reply-To: <1137426168.7853.32.camel@lade.trondhjem.org>
References: <5B305675488C8F97FCE35455@dhcp-2-206.wgops.com>
 <1137426168.7853.32.camel@lade.trondhjem.org>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 16, 2006 10:42:48 AM -0500 Trond Myklebust 
<trond.myklebust@fys.uio.no> wrote:


> AFAIK, most of these bugs have been fixed.
>
> Please try to reproduce the problems on a more recent kernel, or get
> Debian to backport the fixes.


I'll see if I can find a more specific version...I already know we can't 
use anything between 2.6.13 to 2.6.15, maybe including 2.6.15.1 (I'd have 
to test that) because of some sort of either SCSI or aic7xxx driver 
problems.  Even 2.6.8 I occasionally have to cycle our tape library and 
reset the tape server when for some reason the kernel manages to deadlock a 
tape drive when we have more than one tape drive going at once.
