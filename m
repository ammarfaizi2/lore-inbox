Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWDSXgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWDSXgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWDSXgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:36:07 -0400
Received: from ns2.suse.de ([195.135.220.15]:29382 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751328AbWDSXgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:36:06 -0400
Date: Thu, 20 Apr 2006 01:36:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Chris Mason <mason@suse.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] copy_from_user races with readpage
Message-ID: <20060419233601.GO20834@opteron.random>
References: <200604191318.45738.mason@suse.com> <20060419134148.262c61cd.akpm@osdl.org> <17478.46924.439611.402803@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17478.46924.439611.402803@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 08:18:52AM +1000, Neil Brown wrote:
> I would agree with this.

Me too. My patch was more relaxed, but there's no need to alter the real
sigsegv case.
