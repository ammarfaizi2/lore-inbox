Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbTFRJkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 05:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264988AbTFRJkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 05:40:47 -0400
Received: from dns1.seagha.com ([217.66.0.18]:19978 "EHLO relay-1.seagha.com")
	by vger.kernel.org with ESMTP id S264983AbTFRJkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 05:40:47 -0400
Message-ID: <6DED3619289CD311BCEB00508B8E13360117748D@nt-server2.antwerp.seagha.com>
From: Karl Vogel <karl.vogel@seagha.com>
To: "'Oliver Neukum'" <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: RE: How do I make this thing stop laging?  Reboot?  Sounds like  
	Windows!
Date: Wed, 18 Jun 2003 11:56:28 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-15"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Swap prefetching? If you have >10% free physical ram and 
> any used swap it
> > will start swapping pages back into physical ram. Probably 
> not of real
> > benefit but many people like this idea. I have a soft spot 
> for it and like
> > using it.
> > --
> >
> > The disadvantage is ofcourse that you will be using up more 
> RAM than is
> > really necessary.
> 
> No, free RAM is wasted RAM.

But the point is, it's not really free RAM. It's being used for
I/O caching. So while swap prefetching might be suited for
desktop systems, it certainly isn't for servers.


