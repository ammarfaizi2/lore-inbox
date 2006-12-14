Return-Path: <linux-kernel-owner+w=401wt.eu-S1751645AbWLNRw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWLNRw5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWLNRw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:52:57 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:20916 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751645AbWLNRw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:52:56 -0500
X-YMail-OSG: k4m7wh0VM1mjO.GfLsk9Z9lzVaolW.EMQES1qgnefkifWG9yoNFw7Q3anp78riZI5GTHP4gMxI8neRR2PSu8I11jVUSN6tBI9rFvJJAA3pOnvcbohMbrXwxJZIokMayMnOj.XViE7WiXKg--
Date: Thu, 14 Dec 2006 09:52:53 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214175253.GB12498@tuatara.stupidest.org>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <458171C1.3070400@garzik.org> <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org> <20061214170841.GA11196@tuatara.stupidest.org> <20061214173827.GC3452@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214173827.GC3452@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 05:38:27PM +0000, Christoph Hellwig wrote:

> Yes, EXPORT_SYMBOL_INTERNAL would make a lot more sense.

A quick grep shows that changing this now would require updating
nearly 1900 instances, so patches to do this would be pretty large and
disruptive (though we could support both during a transition and
migrate them over time).
