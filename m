Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUJAQRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUJAQRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJAQRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:17:23 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21154 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264503AbUJAQPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:15:08 -0400
Date: Fri, 1 Oct 2004 09:13:25 -0700
From: Paul Jackson <pj@sgi.com>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] inotify: make user visible types portable
Message-Id: <20041001091325.7fbc6971.pj@sgi.com>
In-Reply-To: <1096645624.7676.18.camel@betsy.boston.ximian.com>
References: <1096410792.4365.3.camel@vertex>
	<1096583108.4203.86.camel@betsy.boston.ximian.com>
	<20040930155704.16d71cec.pj@sgi.com>
	<1096608925.4803.2.camel@localhost>
	<20040930234436.097e6dfe.pj@sgi.com>
	<1096616399.4803.26.camel@localhost>
	<20041001084009.6b33c1a1.pj@sgi.com>
	<1096645624.7676.18.camel@betsy.boston.ximian.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert wrote:
> The structure needs to be used exactly the same between the kernel and
> the user.  We both agree to that, right?  It is user visible.

Certainly the ABI, yes.  These stubborn beasts called computers that we
labour over just won't work otherwise.

I'd have no objections to the user header spelling "__u32" where the
kernel header spelled "u32".

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
