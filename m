Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWH1JJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWH1JJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWH1JJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:09:43 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:47035 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932118AbWH1JJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:09:42 -0400
Date: Mon, 28 Aug 2006 05:06:02 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for
  i386.
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Jan Beulich <jbeulich@novell.com>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org
Message-ID: <200608280508_MC3-1-C992-B62D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060827172155.GA21724@rhlx01.fht-esslingen.de>

On Sun, 27 Aug 2006 19:21:55 +0200, Andreas Mohr wrote:

> Something like that had to be done eventually about the inefficient
> current_thread_info() mechanism, but I wasn't sure what exactly.

In 2.6.18 it's done in C and the optimizer does a pretty good job
with it in recent compilers.

-- 
Chuck

