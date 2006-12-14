Return-Path: <linux-kernel-owner+w=401wt.eu-S932811AbWLNPqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932811AbWLNPqY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbWLNPqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:46:24 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47301 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932811AbWLNPqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:46:24 -0500
Message-ID: <458171C1.3070400@garzik.org>
Date: Thu, 14 Dec 2006 10:46:09 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Because I think it's stupid. So use somebody else than me to push your 
> political agendas, please.


ACK, I agree completely.  I think its a silly, political, non-technical 
decision being pushed here.

For the record, I also disagree with the sneaky backdoor way people want 
to add EXPORT_SYMBOL_GPL() to key subsystems that drivers will need. 
EXPORT_SYMBOL_GPL() is more to emphasize that certain symbols are more 
'internal' or frequently changed, and therefore use of them would imply 
you are using a derived work of the kernel.  EXPORT_SYMBOL_GPL() is 
/not/ a place for political activism either.

	Jeff


