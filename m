Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbTIQVrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbTIQVrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:47:33 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:22536 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262836AbTIQVrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:47:32 -0400
Date: Wed, 17 Sep 2003 22:47:28 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: =?ISO-8859-1?Q?Dani=EBl?= Mantione 
	<daniel@deadlock.et.tudelft.nl>,
       "David S. Miller" <davem@redhat.com>, <mroos@linux.ee>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <1063663632.585.61.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309172238511.1730-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why don't you push it to 2.6 first then backport to 2.4 ? That would
> be better imho...

   I have a copy of the 2.6.X port. I tested it on my laptop at work but I 
get a funny matrix effect every 256 pixels on my display. It looks like 
that data from the early pixels is repeated even if it is distored. 
Basically what is in pixel 1 is displayed in pixel 256 but distorted and 
what is displayed in pixel 512 is what should be displayed at pixel 256 
but distorted. Also each distortion band is about 8 pixels wide.
   I wouldn't submit it tho until I can test the patch on a sparc64 
myself to make sure it works.



