Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbTBKUDq>; Tue, 11 Feb 2003 15:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbTBKUDp>; Tue, 11 Feb 2003 15:03:45 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:58766 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S265894AbTBKUDp>; Tue, 11 Feb 2003 15:03:45 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E49366E.10508@murphy.dk>
References: <3E48080F.9060209@murphy.dk>
	 <1044978975.2263.28.camel@passion.cambridge.redhat.com>
	 <3E49366E.10508@murphy.dk>
Organization: 
Message-Id: <1044994408.7004.1.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Feb 2003 20:13:28 +0000
Subject: Re: mtdblock read only device broken?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 17:44, Brian Murphy wrote:

> Thanks, can I download and test it from somewhere?

:pserver:anoncvs@cvs.infradead.org:/home/cvs 

module mtd, password anoncvs.

I'm not entirely convinced the block device drivers work in 2.5 at the
moment. I was holding off on fixing them up, to let the 2.5 code
actually settle down, and to see if those who changed the core code
would fix up the drivers accordingly. My merge from Linus' tree recently
was more focussed on things which were relevant for a merge to 2.4,
rather than merging back to Linus -- that's my next task.

-- 
dwmw2

