Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVHCTji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVHCTji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVHCTji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:39:38 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:62659 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262428AbVHCTji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:39:38 -0400
Subject: Re: [PATCH] Disable the debug.exception-trace sysctl by default
From: Nicholas Miell <nmiell@comcast.net>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050803090344.GI10895@wotan.suse.de>
References: <1122533610.14066.4.camel@localhost.localdomain>
	 <20050803090344.GI10895@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 12:39:33 -0700
Message-Id: <1123097973.2873.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8.njm.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 11:03 +0200, Andi Kleen wrote:
> On Wed, Jul 27, 2005 at 11:53:30PM -0700, Nicholas Miell wrote:
> > debug.exception-trace causes a large amount of log spew when on, and
> > it's on by default, which is an irritation.
> 
> > Here's a patch to turn it off.
> Rejected. 

Why?

Getting 5000 lines of
"inkscape[13137] trap int3 rip:425051 rsp:7fffffa26158 error:0"
in my logs every time I ltrace something is vastly irritating and serves
no useful purpose.

Admittedly, I can (and have) turned this off, but disabling it by
default will probably save somebody else the trouble of figuring out
where this crap is coming from and how to kill it.

-- 
Nicholas Miell <nmiell@comcast.net>

