Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTEVUvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 16:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTEVUvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 16:51:38 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:27288 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263271AbTEVUvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 16:51:37 -0400
Subject: Re: 2.5.69-mm8
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Paul Larson <plars@linuxtestproject.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <9790000.1053632393@[10.10.2.4]>
References: <20030522021652.6601ed2b.akpm@digeo.com>
	 <1053629620.596.1.camel@teapot.felipe-alfaro.com>
	 <1053631843.2648.3248.camel@plars>  <9790000.1053632393@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1053637395.22758.6.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 May 2003 14:03:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 12:39, Martin J. Bligh wrote:
> Also seems to hang rather easily. When it gets into that state, it's difficult
> to tell what works and what doesn't ... I can login over serial, but not 
> start new ssh's and "ps -ef" hangs for ever. I'll try to get some more
> information, and assemble a less-totally-crap bug report.

Give sysrq 't' a shot

echo t > /proc/sysrq-trigger

-- 
Dave Hansen
haveblue@us.ibm.com

