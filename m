Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUAUOn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 09:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbUAUOn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 09:43:28 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:18883 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S262425AbUAUOn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 09:43:27 -0500
Date: Wed, 21 Jan 2004 15:28:02 +0100
From: GCS <gcs@lsc.hu>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5 dies booting, possibly ipv6 related
Message-ID: <20040121142802.GA8840@lsc.hu>
References: <20040120000535.7fb8e683.akpm@osdl.org> <400D083F.6080907@aitel.hist.no> <20040120175408.GA12805@lsc.hu> <20040120102302.47fa26cd.akpm@osdl.org> <400E47CB.5030000@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <400E47CB.5030000@aitel.hist.no>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 10:35:07AM +0100, Helge Hafting <helgehaf@aitel.hist.no> wrote:
[...]
> It still crashes at boot time, in a slightly different way.
> I got an "endless" amount of
> [<c011f202>] register_proc_table+0xc0/0xd6
> scrolling by at high speed.  After a minute or so it ended with
> addr_conf_init
> inet6_init
> oo_initcalls
> init
> init
> kernel_thread_helper
> 
> 
> I have ipv6 compiled into the kernel, others with the same problem
> seems to have this common factor.  
 I have switched off CONFIG_IPV6, and now it boots.

Cheers,
GCS
