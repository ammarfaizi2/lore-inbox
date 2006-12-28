Return-Path: <linux-kernel-owner+w=401wt.eu-S965015AbWL1WyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWL1WyI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWL1WyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:54:07 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39116 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965015AbWL1WyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:54:04 -0500
Date: Thu, 28 Dec 2006 14:53:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-Id: <20061228145336.9f60aaf2.akpm@osdl.org>
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
References: <20061227153855.GA25898@in.ibm.com>
	<20061228082308.GA4476@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 13:53:08 +0530
Suparna Bhattacharya <suparna@in.ibm.com> wrote:

> This patchset implements changes to make filesystem AIO read
> and write asynchronous for the non O_DIRECT case.

I did s/lock_page_slow/lock_page_blocking/g then merged all these
into -mm, thanks.
