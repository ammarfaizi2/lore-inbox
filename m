Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTJWBXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 21:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTJWBXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 21:23:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261433AbTJWBXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 21:23:54 -0400
Date: Thu, 23 Oct 2003 02:23:50 +0100
From: Dave Jones <davej@redhat.com>
To: "Joseph D. Wagner" <theman@josephdwagner.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Message-ID: <20031023012350.GI26476@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Joseph D. Wagner" <theman@josephdwagner.info>,
	linux-kernel@vger.kernel.org
References: <200310221855.15925.theman@josephdwagner.info> <20031023001547.GA18395@redhat.com> <200310221947.45996.theman@josephdwagner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310221947.45996.theman@josephdwagner.info>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 07:47:45PM +0600, Joseph D. Wagner wrote:
 > > Already done for 2.6
 > Version 2.6 is still in beta.  Besides, this should have been done years ago 
 > before 2.6 existed.

They were proposed for 2.4, a while back, and rejected. In part due to
the fact that these option aren't widely tested on kernel code.

 > > Last time I looked these made absolutely no difference to performance
 > > due to the only differences being on FP code.
 > So what?

You can't use FP code in the kernel.

 >This is one of the reasons why I've never contributed to any open source
 >project: the my-way-or-the-highway attitude of the existing developer base
 >makes attempts for newbies to get inside an invintation for unnecessary pain.

You're reading into this far too much.

 > If you don't make the change, I will consider it conclusive proof
 > that the whole free-as-in-freedom is really just free-as-in-beer.

Your proposed change is in part already vetoed (for sound reasons)
for 2.4, and is already included in the development branch
(where such a far-reaching change should be tested). The other part
of your proposal is completely bogus as far as the kernel is concerned.

No amount of 'threats' are going to change this.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
