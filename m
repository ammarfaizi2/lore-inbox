Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUDIRVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUDIRVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:21:42 -0400
Received: from 64.221.211.203.ptr.us.xo.net ([64.221.211.203]:47027 "EHLO
	mail.pathscale.com") by vger.kernel.org with ESMTP id S261443AbUDIRVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:21:40 -0400
Subject: Re: initramfs howto?
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Miles Bader <miles@gnu.org>
Cc: Chris Meadors <clubneon@hereintown.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <buo4qrt4pga.fsf@mcspd15.ucom.lsi.nec.co.jp>
References: <1081451826.238.23.camel@clubneon.priv.hereintown.net>
	 <1081490209.28834.19.camel@camp4.serpentine.com>
	 <buo4qrt4pga.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain
Message-Id: <1081531299.19918.13.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Apr 2004 10:21:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 23:48, Miles Bader wrote:

> If you use that, can you just keep using the initial initramfs as your
> root fs forever?  That'd be swell for embedded systems...

You could do so, yep.

> If so, it'd be nice if it checked for some other name than /init
> (e.g. /sbin/init) -- there's too much crap in / already.

I'm agnostic.  It's a two-line patch.  I don't care if it's called
/spam/fandango/wubble, so long as the brave souls who are trying out
initramfs don't keep stumbling over the same problem again and again :-)

	<b

