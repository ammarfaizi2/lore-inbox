Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVAGTo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVAGTo4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVAGTn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:43:57 -0500
Received: from colin2.muc.de ([193.149.48.15]:34066 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261563AbVAGTlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:41:00 -0500
Date: 7 Jan 2005 20:40:57 +0100
Date: Fri, 7 Jan 2005 20:40:57 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050107194057.GC6518@muc.de>
References: <3174569B9743D511922F00A0C94314230729131E@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230729131E@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 11:43:52AM -0800, YhLu wrote:
> Amd 8111 and 8131 only have 4 bit for apcid. So it only can use 0-15.

How broken. Ok. But I still don't like your patch. You should
give the BSP ID 0 and for the others it shouldn't matter anyways
if they use high APICIDs. 

-Andi
