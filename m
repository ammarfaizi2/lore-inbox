Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVASRrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVASRrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVASRrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:47:35 -0500
Received: from mail.suse.de ([195.135.220.2]:32474 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261813AbVASRpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:45:12 -0500
Date: Wed, 19 Jan 2005 18:45:06 +0100
From: Andi Kleen <ak@suse.de>
To: Steve Longerbeam <stevel@mvista.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andi Kleen <ak@suse.de>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG in shared_policy_replace() ?
Message-ID: <20050119174506.GH7445@wotan.suse.de>
References: <Pine.LNX.4.44.0501191221400.4795-100000@localhost.localdomain> <41EE9991.6090606@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EE9991.6090606@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> got it, except that there is no "new2 = NULL;" in 2.6.10-mm2!
> 
> Looks like it was misplaced, because I do see it now in 2.6.10.

I double checked 2.6.10 and the code also looks correct me,
working as described by Hugh.

Optimistic locking can be ugly :)

-Andi
