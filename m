Return-Path: <linux-kernel-owner+w=401wt.eu-S932080AbXAOWzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbXAOWzh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 17:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbXAOWzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 17:55:37 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:37480 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbXAOWzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 17:55:33 -0500
Date: Mon, 15 Jan 2007 23:55:31 +0100
From: Simon Budig <simon@budig.de>
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] USB HID: proper LED-mapping (support for SpaceNavigator)
Message-ID: <20070115225531.GA8483@budig.de>
References: <20070114231135.GA29966@budig.de> <Pine.LNX.4.64.0701150938180.16747@twin.jikos.cz> <20070115162541.GA3751@budig.de> <Pine.LNX.4.64.0701151743170.16747@twin.jikos.cz> <20070115173216.GA4582@budig.de> <Pine.LNX.4.64.0701152210530.16747@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701152210530.16747@twin.jikos.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina (jikos@jikos.cz) wrote:
> On Mon, 15 Jan 2007, Simon Budig wrote:
> > Is it possible that there is a regression in the hid-debug stuff? The
> > mapping does not seem to appear in the dmesg-output. I unfortunately
> > don't have an earlier kernel available right now to verify, but now the
> > output on plugging in the device looks like this:
> 
[...]
> (after I check why the debug output seems to be broken),

Actually this might have been a false alarm. I remembered about
/var/log/messages and looked up how this looked like with earlier
kernels - turns out it looks exactly the same.

(the values dumped there seem to be the initial values of a given field
in a HID-Report)

So there is no regression there, sorry about the confusion.

Bye,
        Simon
-- 
              simon@budig.de              http://simon.budig.de/
