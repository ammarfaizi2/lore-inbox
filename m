Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTEAD6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 23:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbTEAD6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 23:58:16 -0400
Received: from franka.aracnet.com ([216.99.193.44]:23264 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262225AbTEAD6P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 23:58:15 -0400
Date: Wed, 30 Apr 2003 21:10:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>, rmoser <mlmoser@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel source tree splitting
Message-ID: <9930000.1051762204@[10.10.2.4]>
In-Reply-To: <20030430172102.69e13ce9.rddunlap@osdl.org>
References: <200304301946130000.01139CC8@smtp.comcast.net>
 <20030430172102.69e13ce9.rddunlap@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm probably misreading this...but,
> 
> Have you tried this yet?  Does it modify/customize all Kconfig
> and Makefiles for the selected tree splits?
> 
> A few days ago, in one tree, I rm-ed arch/{all that I don't need}
> and drivers/{all that I don't need}.
> After that I couldn't run "make *config" because it wants all of
> those files, even if I don't want them.
> 
> So there are many edits that needed to be done in lots of
> Kconfig and Makefiles if one selectively pulls or omits certain
> sub-directories.

Indeed, I ran across the same thing a while back. Would be *really* nice to
fix, if only so some poor sod over a modem can download a smaller tarball,
or save some diskspace.

M.

