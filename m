Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753043AbVHGX5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbVHGX5C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 19:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbVHGX5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 19:57:01 -0400
Received: from dvhart.com ([64.146.134.43]:641 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1753040AbVHGX5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 19:57:01 -0400
Date: Sun, 07 Aug 2005 16:57:05 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] abstract out bits of ldt.c
Message-ID: <374910000.1123459025@[10.10.2.4]>
In-Reply-To: <20050807234411.GE7991@shell0.pdx.osdl.net>
References: <372830000.1123456808@[10.10.2.4]> <20050807234411.GE7991@shell0.pdx.osdl.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Chris Wright <chrisw@osdl.org> wrote (on Sunday, August 07, 2005 16:44:11 -0700):

> * Martin J. Bligh (mbligh@mbligh.org) wrote:
>> Starting on the work to merge xen cleanly as a subarch.
>> Introduce make_pages_readonly and make_pages_writable where appropriate 
>> for Xen, defined as a no-op on other subarches. Same for 
> 
> Maybe this is a bad name, since make_pages_readonly/writable has
> intutitive meaning, and then is non-inutitively a no-op (for default).

You're welcome to suggest something else if you want, though it would
have been easier if you'd done it the first time you saw this patch,
not now. Going through this stuff multiple times is going to get very
boring very fast.

xen_make_pages_readonly / xen_make_pages_writable ?

M.

