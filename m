Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVKBQUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVKBQUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbVKBQUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:20:11 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:60297 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965116AbVKBQUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:20:10 -0500
Date: Wed, 2 Nov 2005 11:20:09 -0500
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Message-ID: <20051102162009.GA9488@csclub.uwaterloo.ca>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade> <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade> <20051027211203.M33358@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051027211203.M33358@linuxwireless.org>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 05:15:50PM -0400, Alejandro Bonilla wrote:
> AFAIK, No. AMD and Intel will always do the same thing until we all move to
> real IA64.

Many boards DO allow remapping memory past 3GB to the 4GB+ area to make
it accessable.  There should be a BIOS option for remapping memory or
letting software create a memory hole at 3GB.  It is NOT normal to not
allow full access to all the memeory on an amd64/em64t system.  Of
course the bios defaults are often set so as to provide as much ram to a
32bit OS as possible at the expense of doing it properly for a 64bit OS.

And it looks like the world has no intension of ever moving to IA64, and
that's probably for the best.  PowerPC or Alpha or something would make
more sense if you are going to drop x86.

> Unless there is some sort of kernel hack that will do some crazy thing to give
> you the power there.
> 
> But hey, look at it this way, if you remove 1GB, you will lose the Dual
> Channel capability.

Len Sorensen
