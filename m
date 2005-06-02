Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFBSv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFBSv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVFBSv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:51:56 -0400
Received: from colin.muc.de ([193.149.48.1]:44807 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261237AbVFBSvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:51:54 -0400
Date: 2 Jun 2005 20:51:53 +0200
Date: Thu, 2 Jun 2005 20:51:53 +0200
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor e dual way
Message-ID: <20050602185153.GG1683@muc.de>
References: <3174569B9743D511922F00A0C94314230A403903@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230A403903@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 08:26:00PM -0700, YhLu wrote:
> Brought up 4 CPUs
>     CPU 0, cpu_sibling_map[0]= 1 
>     CPU 0, cpu_core_map[0]= 3 
>     CPU 1, cpu_sibling_map[1]= 2 
>     CPU 1, cpu_core_map[1]= 3 
>     CPU 2, cpu_sibling_map[2]= 4 
>     CPU 2, cpu_core_map[2]= c 
>     CPU 3, cpu_sibling_map[3]= 8 
>     CPU 3, cpu_core_map[3]= c 
> are the cpu_sibling_map[] right? 

Yes it is correct. A CPU is always a sibling of itself.

-Andi
