Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWH3RIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWH3RIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWH3RIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:08:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:5845 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751159AbWH3RId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:08:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=n9ATOao72K1PESDHhn1LTQzKywGt5+JuXT9/FIfoPw4Et0/2cIotbVmRe5X+V2Mewe0TvfcpitkCc3Q9P4IEhKu+RWlNFfvnowqMtu8l+IZ00y0lD/2IVprH7ty9wsYo+Yi7EphI/7JG8adQcqCYZOhY1ZBlBPQnQkg4UhQ1VL8=
Date: Wed, 30 Aug 2006 20:06:38 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
Message-ID: <20060830200638.504602e2@localhost>
In-Reply-To: <200608301856.11125.ak@suse.de>
References: <44F1F356.5030105@zytor.com>
	<44F3555F.6060306@zytor.com>
	<20060830194942.12cbf169@localhost>
	<200608301856.11125.ak@suse.de>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 18:56:11 +0200
Andi Kleen <ak@suse.de> wrote:
> IA64 booting is completely different. I don't think it should 
> be in this patch. At least you would need to check with the IA64
> maintainer first.

OK... no problem.

> 
> And the other thing is that this will cost memory. Either make
> it dependend on !CONFIG_SMALL or fix the boot code to save the 
> command line into a kmalloc'ed buffer of the right size and __init 
> the original one

I don't mind doing either... Any preference for one of them? The
kmalloc approach seems nicer..

Best Regards,
Alon Bar-Lev.
