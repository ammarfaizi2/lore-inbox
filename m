Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161583AbWJDQmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161583AbWJDQmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161582AbWJDQmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:42:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:36845 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161577AbWJDQmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:42:01 -0400
Subject: Re: 2.6.18-mm2 boot failure on x86-64
From: Steve Fox <drfickle@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Vivek Goyal <vgoyal@in.ibm.com>
In-Reply-To: <20061004084540.af17fee5.akpm@osdl.org>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <efh217$8au$1@sea.gmane.org> <20060928140124.5f7154e3.akpm@osdl.org>
	 <1159969349.28106.64.camel@flooterbu>
	 <20061004084540.af17fee5.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 11:41:59 -0500
Message-Id: <1159980119.28106.75.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 08:45 -0700, Andrew Morton wrote:
> On Wed, 04 Oct 2006 08:42:28 -0500
> Steve Fox <drfickle@us.ibm.com> wrote:
> > Sorry for the delay. I was finally able to perform a bisect on this. It
> > turns out the patch that causes this is
> > x86_64-mm-re-positioning-the-bss-segment.patch, which seems like a
> > strange candidate, but sure enough I can boot to login: right up until
> > that patch is applied.
> 
> hm, that patch was merged into mainline September 29.  Does mainline work?

-git21 also fails with this same error.

-- 

Steve Fox
IBM Linux Technology Center
