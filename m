Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVILQME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVILQME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVILQME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:12:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12970 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932065AbVILQMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:12:02 -0400
Date: Mon, 12 Sep 2005 08:47:56 -0700
From: Paul Jackson <pj@sgi.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mrmacman_g4@mac.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       bunk@stusta.de
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined
 by GCC from 2.95 to current CVS)
Message-Id: <20050912084756.4fa2bd07.pj@sgi.com>
In-Reply-To: <43259C9E.1040300@zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
	<20050903064124.GA31400@codepoet.org>
	<4319BEF5.2070000@zytor.com>
	<B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>
	<dfhs4u$1ld$1@terminus.zytor.com>
	<5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com>
	<9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com>
	<97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com>
	<20050910014543.1be53260.akpm@osdl.org>
	<4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com>
	<20050910150446.116dd261.akpm@osdl.org>
	<E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com>
	<20050910174818.579bc287.akpm@osdl.org>
	<93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com>
	<20050912010954.70ac90e2.pj@sgi.com>
	<43259C9E.1040300@zytor.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa wrote:
> The only sane thing is to have a set of ABI headers with a clean, 
> specific set of rules, which is included by the kernel private headers, 
> as well as userspace.

Why must the ABI headers be included by both kernel and user headers to
be sane?

Hmmm ... I'm not sure I want to ask that, actually.  I have this feeling
from the tone of your assertion that you can explain to me why such a
header organization is the only one that fits your mental model of how
these things are structured, but that communication between us may
break down when you try to convince me that your mental model for this
is the only correct one.

Oh well ... we'll see where this goes.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
