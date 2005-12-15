Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVLODDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVLODDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVLODDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:03:51 -0500
Received: from kanga.kvack.org ([66.96.29.28]:57490 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965010AbVLODDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:03:51 -0500
Date: Wed, 14 Dec 2005 22:00:40 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, linux-mm@kvack.org, tony.luck@intel.com
Subject: Re: 2.6.15-rc5-mm2 can't boot on ia64 due to changing on_each_cpu().
Message-ID: <20051215030040.GA28660@kvack.org>
References: <20051215103344.241C.Y-GOTO@jp.fujitsu.com> <20051214185658.7a60aa07.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214185658.7a60aa07.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 06:56:58PM -0800, Andrew Morton wrote:
> Thanks.  I'll drop it.

Please don't.  Fix ia64's brain damage instead.  Function pointers 
should not be cast, period.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
