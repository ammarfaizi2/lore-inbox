Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTEMOhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTEMOhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:37:40 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:48283 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261326AbTEMOhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:37:38 -0400
Date: Tue, 13 May 2003 10:45:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Jesse Pollard <jesse@cats-chateau.net>, Yoav Weiss <ml-lkml@unpatched.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Message-ID: <200305131048_MC3-1-38B1-E13F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:

> > However, it'll just give you false sense of security.  First of all, its
> > hardware dependent.  Second, it won't get wipe in case of a crash (which
> > is likely to happen when They come to take your disk).
>
> It is also not a valid wipe either.
> 
> This particular object reuse assumes the hardware is in a secured area. If it
> is in a secured area then you don't need to wipe it. It remains completely 
> under the systems control (even during a crash and reboot). The interval 
> between crash and reboot is covered by the requirement to be in a secured 
> area.

  ...until the admin walks in, shuts down the system, puts it on a cart
and hauls it out the door.  Is he going to wipe the swap area before he
does that?  Sure, you can write a procedure that says that's what he does
but he will not follow it (been there done that.)


