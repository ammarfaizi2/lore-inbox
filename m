Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVCOIuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVCOIuU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 03:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVCOIuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 03:50:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58512 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262340AbVCOIuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 03:50:16 -0500
Date: Tue, 15 Mar 2005 00:47:59 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: mpm@selenic.com, phillip@lougher.demon.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH][1/2] SquashFS
Message-Id: <20050315004759.473f6a0b.pj@engr.sgi.com>
In-Reply-To: <42363EAB.3050603@yahoo.com.au>
References: <4235BAC0.6020001@lougher.demon.co.uk>
	<20050315003802.GH3163@waste.org>
	<42363EAB.3050603@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the overall kernel (Linus's bk tree) I count:

	733 lines matching 'for *( *; *; *)'
	718 lines matching 'while *( *1 *)'

In the kernel/*.c files, I count 15 of the 'for(;;)' style and 1 of the
'while(1)' style.

Certainly the 'for(;;)' style is acceptable, and even slightly to
substantially dominant, depending on which piece of code you're in.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
