Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWCHKTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWCHKTs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 05:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWCHKTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 05:19:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:36480 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751049AbWCHKTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 05:19:47 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.16-rc5-mm3 oopses on modprobe p4_clockmod
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060308012347.47538bf4.akpm@osdl.org>
References: <1141809107.7841.5.camel@homer>
	 <20060308012347.47538bf4.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 11:20:26 +0100
Message-Id: <1141813226.7770.1.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 01:23 -0800, Andrew Morton wrote:

> err, I think this was me breaking stuff.
> 
> You have CONFIG_HOTPLUG_CPU=n, yes?

Yes, that fixed it.  I would have been back sooner with confirmation,
but after touching that option, make decided to rebuild the galaxy.

	-Mike

