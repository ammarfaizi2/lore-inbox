Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUHTOsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUHTOsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUHTOsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:48:50 -0400
Received: from mail1.kontent.de ([81.88.34.36]:29361 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268134AbUHTOsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:48:46 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: PF_MEMALLOC in 2.6
Date: Fri, 20 Aug 2004 16:50:07 +0200
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <4125B111.2040308@yahoo.com.au> <20040820014005.73383a43@lembas.zaitcev.lan>
In-Reply-To: <20040820014005.73383a43@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201650.07513.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you let me gloat for a little bit, ub makes this discussion moot
> because it has no helper thread. But getting back to usb-storage,

But ub supports only a subset of storage devices, doesn't it?

[..] 
> This is what made me suspect that it's the diry memory writeout problem.
> It's just like how it was on 2.4 before Alan added PF_MEMALLOC.

If we add PF_MEMALLOC, do we solve the issue or make it only less
likely? Isn't there a need to limit users of the reserves in number?

	Regards
		Oliver
