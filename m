Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285555AbRLNW1t>; Fri, 14 Dec 2001 17:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285556AbRLNW1j>; Fri, 14 Dec 2001 17:27:39 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:38717 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285555AbRLNW1a>; Fri, 14 Dec 2001 17:27:30 -0500
Date: Fri, 14 Dec 2001 17:27:28 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] mempool-2.5.1-D2
Message-ID: <20011214172728.B26535@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112141908420.12688-200000@localhost.localdomain> <Pine.LNX.4.33.0112142008520.14764-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112142008520.14764-200000@localhost.localdomain>; from mingo@elte.hu on Fri, Dec 14, 2001 at 08:13:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 08:13:49PM +0100, Ingo Molnar wrote:
> 
> Andrew Morton noticed another bug, run_tasklist() should not be called as
> TASK_UNINTERRUPTIBLE. The attached patch fixes this.

Btw, wouldn't reservation result in the same effect as these mempools for 
significantly less code?

		-ben
