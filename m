Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262764AbTCYQcd>; Tue, 25 Mar 2003 11:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262768AbTCYQcd>; Tue, 25 Mar 2003 11:32:33 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:55489 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262764AbTCYQcc>; Tue, 25 Mar 2003 11:32:32 -0500
Date: Tue, 25 Mar 2003 16:43:25 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: cacheline size detection code in 2.5.66
Message-ID: <20030325164317.GA4019@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andi Kleen <ak@muc.de>,
	linux-kernel@vger.kernel.org
References: <20030325071532.GA19217@averell> <20030325143310.A3487@jurassic.park.msu.ru> <20030325121527.GA29965@averell> <20030325124333.GB28451@suse.de> <20030325133525.GA30321@averell> <20030325173937.A21821@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325173937.A21821@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 05:39:37PM +0300, Ivan Kokshaysky wrote:
 > On Tue, Mar 25, 2003 at 02:35:25PM +0100, Andi Kleen wrote:
 > > Ivan confused me.  Either he read the application note wrong or it is wrong.
 > 
 > Ok, it's available at
 > http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/20734.pdf
 
For info, that is a reliable[*] way to detect XP/MP Athlons.
It's used in the kernel for SMP tainting, and x86info has also been
using it for some time.

		Dave

[*] AMD screwed up one stepping of XPs and enabled the MP bit even though
    they weren't actually MPs.

