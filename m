Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbTJNP2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 11:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbTJNP2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 11:28:10 -0400
Received: from colin2.muc.de ([193.149.48.15]:51726 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262557AbTJNP2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 11:28:09 -0400
Date: 14 Oct 2003 17:28:26 +0200
Date: Tue, 14 Oct 2003 17:28:26 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide barrier support, #2
Message-ID: <20031014152826.GA9391@colin2.muc.de>
References: <GurO.7cg.43@gated-at.bofh.it> <m3zng4ou90.fsf@averell.firstfloor.org> <20031014125723.GR1107@suse.de> <20031014150807.GA99122@colin2.muc.de> <20031014151230.GS1107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014151230.GS1107@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> See the patch, WRITESYNC is used solely internally in raid1.
> WRITEBARRIER is a bitmask of BIO_RW and BIO_RW_BARRIER and that is what
> you want. I'll make that more clear. Writes will not be reordered around
> the barrier either, btw.

It would be still misnamed. I want a flush and not a barrier.

Anyways, when you apply the patch just change the cmd that what
you think is right.

-Andi
