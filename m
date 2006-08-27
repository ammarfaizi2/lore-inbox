Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWH0SFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWH0SFM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWH0SFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:05:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:1479 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932219AbWH0SFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:05:10 -0400
From: Andi Kleen <ak@suse.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
Date: Sun, 27 Aug 2006 20:04:38 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060827084417.918992193@goop.org> <20060827172155.GA21724@rhlx01.fht-esslingen.de>
In-Reply-To: <20060827172155.GA21724@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608272004.38280.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Something like that had to be done eventually about the inefficient
> current_thread_info() mechanism, 

Inefficient? It's two fast instructions. I won't call that inefficient.

> I guess it's due to having tried that on an older installation with gcc 3.2,
> which probably does less efficient opcode merging of current_thread_info()
> requests compared to a current gcc version.

gcc normally doesn't merge inline assembly at all.

-Andi
