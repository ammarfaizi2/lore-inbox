Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267666AbUHJVlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267666AbUHJVlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267753AbUHJVjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:39:09 -0400
Received: from jade.spiritone.com ([216.99.193.136]:27349 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267740AbUHJVgV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:36:21 -0400
Date: Sun, 08 Aug 2004 19:53:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Paul Jackson <pj@sgi.com>
cc: alex.williamson@hp.com, haveblue@us.ibm.com,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: [PATCH] cleanup ACPI numa warnings
Message-ID: <2550950000.1092019997@[10.10.2.4]>
In-Reply-To: <20040808143631.7c18cae9.rddunlap@osdl.org>
References: <1091738798.22406.9.camel@tdi><1091739702.31490.245.camel@nighthawk><1091741142.22406.28.camel@tdi><249150000.1091763309@[10.10.2.4]><20040805205059.3fb67b71.rddunlap@osdl.org><20040807105729.6adea633.pj@sgi.com> <20040808143631.7c18cae9.rddunlap@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--"Randy.Dunlap" <rddunlap@osdl.org> wrote (on Sunday, August 08, 2004 14:36:31 -0700):

> On Sat, 7 Aug 2004 10:57:29 -0700 Paul Jackson wrote:
> 
>| > And there's nothing in CodingStyle that agrees with you that I could find.
>| 
>| > From the file Documentation/SubmittingPatches:
>| 
>|         3) 'static inline' is better than a macro
>| 
>|         Static inline functions are greatly preferred over macros.
>|         They provide type safety, have no length limitations, no formatting
>|         limitations, and under gcc they are as cheap as macros.
>| 
>|         Macros should only be used for cases where a static inline is clearly
>|         suboptimal [there a few, isolated cases of this in fast paths],
>|         or where it is impossible to use a static inline function [such as
>|         string-izing].
> 
> Oops.  Thanks, Paul.
> 
> I agree that the inline looks better than the macro (more readable,
> possibly more maintainable), but not that the multi-line macro
> is _evil_ (which is what Martin said).

It's not that this multi-line macro was particularly offensive ... it's
that I've seen the most heinous crap in the past ... and the only sensible
place I can find to draw a line is ... no multiline macros ;-)

M.

