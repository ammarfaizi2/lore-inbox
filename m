Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVH2WKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVH2WKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVH2WKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:10:35 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:11078 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1751343AbVH2WKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:10:35 -0400
X-IronPort-AV: i="3.96,151,1122872400"; 
   d="scan'208"; a="286341426:sNHT26270552"
Date: Mon, 29 Aug 2005 17:10:34 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Daniel Drake <dsd@gentoo.org>
Cc: akpm@osdl.org, frank@google.com, linux-kernel@vger.kernel.org,
       james.cameron@hp.com
Subject: Re: ppp_mppe+pptp for 2.6.14?
Message-ID: <20050829221034.GA4161@lists.us.dell.com>
References: <431341F4.8010200@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431341F4.8010200@gentoo.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 06:12:20PM +0100, Daniel Drake wrote:
> Hi,
> 
> If there are no known issues it would be nice to push this for inclusion in 
> 2.6.14. The relevant patches from -mm are named 
> ppp_mppe-add-ppp-mppe-encryption-module.patch and 
> ppp_mppe-add-ppp-mppe-encryption-module-update.patch
> 
> Judging by the feedback I get from Gentoo users, there is high demand for 
> this :)


This patch has been working fine for me for several weeks now.

I've asked James Cameron, pptp project lead, to try a test to force
the server side to issue a CCP DOWN, to make sure the client-side
kernel ppp_generic module does the right thing and drops packets.  I
don't have a testbed that allows such, but he does.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
