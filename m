Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUHHVrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUHHVrl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 17:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUHHVrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 17:47:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:20869 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265038AbUHHVrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 17:47:19 -0400
Date: Sun, 8 Aug 2004 14:36:31 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: mbligh@aracnet.com, alex.williamson@hp.com, haveblue@us.ibm.com,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: [PATCH] cleanup ACPI numa warnings
Message-Id: <20040808143631.7c18cae9.rddunlap@osdl.org>
In-Reply-To: <20040807105729.6adea633.pj@sgi.com>
References: <1091738798.22406.9.camel@tdi>
	<1091739702.31490.245.camel@nighthawk>
	<1091741142.22406.28.camel@tdi>
	<249150000.1091763309@[10.10.2.4]>
	<20040805205059.3fb67b71.rddunlap@osdl.org>
	<20040807105729.6adea633.pj@sgi.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2004 10:57:29 -0700 Paul Jackson wrote:

| > And there's nothing in CodingStyle that agrees with you that I could find.
| 
| >From the file Documentation/SubmittingPatches:
| 
|         3) 'static inline' is better than a macro
| 
|         Static inline functions are greatly preferred over macros.
|         They provide type safety, have no length limitations, no formatting
|         limitations, and under gcc they are as cheap as macros.
| 
|         Macros should only be used for cases where a static inline is clearly
|         suboptimal [there a few, isolated cases of this in fast paths],
|         or where it is impossible to use a static inline function [such as
|         string-izing].

Oops.  Thanks, Paul.

I agree that the inline looks better than the macro (more readable,
possibly more maintainable), but not that the multi-line macro
is _evil_ (which is what Martin said).


--
~Randy
