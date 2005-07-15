Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbVGOCLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbVGOCLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbVGOCLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:11:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23169 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263154AbVGOCJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:09:19 -0400
Date: Fri, 15 Jul 2005 04:09:14 +0200
From: Andi Kleen <ak@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Chris Friesen <cfriesen@nortel.com>, Andi Kleen <ak@suse.de>,
       Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Message-ID: <20050715020914.GQ23737@wotan.suse.de>
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel> <p73wtnsx5r1.fsf@bragg.suse.de> <9a8748490507141845162c0f19@mail.gmail.com> <42D71950.20303@nortel.com> <9a8748490507141906fb7e5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490507141906fb7e5b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can't test everything this way, nor should you, but you can test
> many things, and adding a bit of formal testing to the release
> procedure wouldn't be a bad thing IMO.

In the linux model that's left to the distributions. In fact doing it properly
takes months. You wouldn't want to wait months for a new mainline kernel.

Formal testing is not really compatible with "release early, release often" 

You could do things like "run LTP first", but in practice LTP rarely finds
bugs.

-Andi
