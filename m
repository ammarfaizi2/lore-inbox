Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUHGR6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUHGR6g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUHGR6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:58:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13486 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263971AbUHGR6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:58:25 -0400
Date: Sat, 7 Aug 2004 10:57:29 -0700
From: Paul Jackson <pj@sgi.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: mbligh@aracnet.com, alex.williamson@hp.com, haveblue@us.ibm.com,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: [PATCH] cleanup ACPI numa warnings
Message-Id: <20040807105729.6adea633.pj@sgi.com>
In-Reply-To: <20040805205059.3fb67b71.rddunlap@osdl.org>
References: <1091738798.22406.9.camel@tdi>
	<1091739702.31490.245.camel@nighthawk>
	<1091741142.22406.28.camel@tdi>
	<249150000.1091763309@[10.10.2.4]>
	<20040805205059.3fb67b71.rddunlap@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And there's nothing in CodingStyle that agrees with you that I could find.

>From the file Documentation/SubmittingPatches:

        3) 'static inline' is better than a macro

        Static inline functions are greatly preferred over macros.
        They provide type safety, have no length limitations, no formatting
        limitations, and under gcc they are as cheap as macros.

        Macros should only be used for cases where a static inline is clearly
        suboptimal [there a few, isolated cases of this in fast paths],
        or where it is impossible to use a static inline function [such as
        string-izing].

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
