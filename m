Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWIUTdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWIUTdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWIUTdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:33:38 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:53161 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751345AbWIUTdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:33:37 -0400
Message-ID: <4512E910.6000308@oracle.com>
Date: Thu, 21 Sep 2006 12:33:36 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Andrew Morton'" <akpm@osdl.org>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       linux-kernel@vger.kernel.org, linux-aio <linux-aio@kvack.org>
Subject: Re: [patch] clean up unused kiocb variables
References: <000001c6ddaf$40d4eff0$ff0da8c0@amr.corp.intel.com>
In-Reply-To: <000001c6ddaf$40d4eff0$ff0da8c0@amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Any reason why we keep these two variables around for kiocb structure?

If there is a good one I've forgotten it.

> They are not used anywhere.

Indeed.

The ki_retried users all seem pretty questionable, too.  How about
removing all that stuff?

> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

Signed-off-by: Zach Brown <zach.brown@oracle.com>

- z
