Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbVALAnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVALAnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVALAnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:43:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:11440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262967AbVALAfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:35:06 -0500
Date: Tue, 11 Jan 2005 16:35:04 -0800
From: Chris Wright <chrisw@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Chris Wright <chrisw@osdl.org>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: node_online_map patch kills x86_64
Message-ID: <20050111163504.D24171@build.pdx.osdl.net>
References: <20050111151656.A24171@build.pdx.osdl.net> <20050112000726.GD14443@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050112000726.GD14443@holomorphy.com>; from wli@holomorphy.com on Tue, Jan 11, 2005 at 04:07:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III (wli@holomorphy.com) wrote:
> On Tue, Jan 11, 2005 at 03:16:56PM -0800, Chris Wright wrote:
> > Backing out the x86_64 specific bits of the numnodes -> node_online_map
> > patch and the generic bits from wli, kills my machine at boot.
> > It hits the early_idt_handler and dies straight away.  What would help
> > to debug this thing?
> 
> The only part of this I'm responsible for is converting build_zonelists()
> to pass its nodemask argument by reference to address a livelock. I feel
> your pain and if not otherwise occupied I would help fix your problem
> right away.

Thanks wli.  Seems Andi understands the issue despite my unintelligible
bug report ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
