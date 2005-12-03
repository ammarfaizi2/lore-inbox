Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVLCLtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVLCLtm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 06:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVLCLtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 06:49:42 -0500
Received: from www4.pochta.ru ([81.211.64.24]:62265 "EHLO www4.pochta.ru")
	by vger.kernel.org with ESMTP id S1751210AbVLCLtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 06:49:41 -0500
Date: Sat, 3 Dec 2005 14:49:36 +0300 (MSK)
From: vitalhome@rbcmail.ru
Message-Id: <200512031149.jB3Bna5h049169@www4.pochta.ru>
To: mark.underwood@philips.com
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Free mail service Pochta.ru; WebMail Client; Account: vitalhome@rbcmail.ru
X-Proxy-IP: [195.242.0.161]
X-Originating-IP: [195.201.72.10]
Subject: Re: [PATCH 2.6-git] SPI core refresh
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

> > >I still do not see why you are stating this.  Why do you say this?
> > > 
> > >
> > Due to possible priority inversion problems in David's core.
> 
> Which you still haven't proven, in fact you now seem to be changing your mind and saying 
> that
> there might be a problem if an adapter driver was implemented badly although I still 
> don't see how
> this could happen (the priority inversion I mean not the badly implemented driver ;).

Truly admiring your deep understanding of the real-time technology, I should remind you 
that within the real-time conditions almost each event may happen and may not happen, for 
instance, two calls from different context to the same funtion may happen at the same or 
almost the same time, and may not happen that way. Therefore I used the word "possible". 
Hope I clarified that a bit for you.

Please also see my previous emails for the explanation of how priority inversion can 
happen. This is not gonna be a rare case, BTW.

Vitaly
