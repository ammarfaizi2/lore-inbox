Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267261AbTGSMNN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 08:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbTGSMNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 08:13:13 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:50898 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S267261AbTGSMNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 08:13:12 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
References: <20030711140219.GB16433@suse.de> <3F170D0F.7070304@pobox.com>
	<20030717211623.GA2289@matchmail.com> <3F1713E5.6020206@pobox.com>
	<20030718091018.A16388@infradead.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Jul 2003 20:48:28 +0200
In-Reply-To: <20030718091018.A16388@infradead.org>
Message-ID: <m34r1jy8lf.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> > Even though net devices are independently refcounted and internally 
> > consistent, I have no idea if the module's code is refcounted elsewhere 
> > or not.  So, I hope it's safe...
> 
> With the rmmod -a cronjobs some people like to run it'll break horribly :)

Yes. I think rmmod -a (and modprobe -r) should go away then - unless the
correct behavior is back.
-- 
Krzysztof Halasa
Network Administrator
