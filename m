Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUHDTvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUHDTvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267394AbUHDTvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:51:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:19656 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267382AbUHDTvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:51:39 -0400
Date: Wed, 4 Aug 2004 12:50:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
       ricklind@us.ibm.com
Subject: Re: 2.6.8-rc2-mm2 performance improvements (scheduler?)
Message-Id: <20040804125005.544e9304.akpm@osdl.org>
In-Reply-To: <211490000.1091648060@flay>
References: <6560000.1091632215@[10.10.2.4]>
	<7480000.1091632378@[10.10.2.4]>
	<20040804122414.4f8649df.akpm@osdl.org>
	<211490000.1091648060@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> PS. schedstats is great for this kind of thing. Very useful, minimally 
>  invasive, no impact unless configed in, and nothing measurable even then.
>  Hint. Hint ;-)

Ho hum.  It's up to the hordes of scheduler hackers really.  If they want,
and can agree upon a patch then go wild.  It should be against -mm minus
staircase, as there's a fair amount of scheduler stuff banked up for
post-2.6.8.
