Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271410AbTHHOnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271411AbTHHOnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:43:14 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:28654 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S271410AbTHHOnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:43:11 -0400
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
From: David Woodhouse <dwmw2@infradead.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Nicolas Pitre <nico@cam.org>, Willy Tarreau <willy@w.ods.org>,
       Christoph Hellwig <hch@lst.de>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3F33B5B5.6050705@develer.com>
References: <Pine.LNX.4.44.0307281307480.6507-100000@xanadu.home>
	 <200307290102.01313.bernie@develer.com>
	 <1060349104.25209.364.camel@passion.cambridge.redhat.com>
	 <3F33B5B5.6050705@develer.com>
Content-Type: text/plain
Message-Id: <1060353783.25209.510.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Fri, 08 Aug 2003 15:43:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-08 at 15:37, Bernardo Innocenti wrote:
> So, let's try to remove the block layer from the kernel.
> Do you reckon it would be difficult to do?

Depends how thorough you want to be. I wanted to go the whole way and
actually remove the definition of struct buffer_head, then remove all
the code which would no longer compile at all..

You could be slightly less enthusiastic about it and make life easier
for yourself, I suppose.

-- 
dwmw2

