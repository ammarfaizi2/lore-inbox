Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUEGWwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUEGWwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 18:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUEGWwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 18:52:16 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:16540 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263824AbUEGWwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 18:52:14 -0400
Date: Sat, 8 May 2004 02:51:42 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Christoph Hellwig <hch@lst.de>, rth@twiddle.net,
       linux-kernel@vger.kernel.org
Subject: Re: alpha fp-emu vs module refcounting
Message-ID: <20040508025142.A4330@jurassic.park.msu.ru>
References: <20040507110217.GA11366@lst.de> <20040507183208.A3283@jurassic.park.msu.ru> <20040507143512.GA14338@lst.de> <20040508023717.A3960@jurassic.park.msu.ru> <20040507224104.GA21153@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040507224104.GA21153@lst.de>; from hch@lst.de on Sat, May 08, 2004 at 12:41:04AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 12:41:04AM +0200, Christoph Hellwig wrote:
> either that or just marking it unloadable by removing the cleanup_module
> handler sound like the simplest solution I guess.

Or leave it as it is for now - 'CONFIG_MATHEMU=m' won't compile. ;-)

Ivan.
