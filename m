Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVCCXQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVCCXQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVCCW74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:59:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:9439 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262679AbVCCW4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:56:04 -0500
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for
	openfirmware	devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42275536.8060507@suse.com>
References: <20050301211824.GC16465@locomotive.unixthugs.org>
	 <1109806334.5611.121.camel@gaston>  <42275536.8060507@suse.com>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 09:52:56 +1100
Message-Id: <1109890376.5679.236.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Reviewing the 'compatible' values in my device-tree, I definately agree.
> I can hack the pmac_zilog driver to test this out further - I've just
> been using my airport card.
> 
> Are there any other "invalid" characters for the compatible property?
> CRLF would work, but these values (as a group) need to be put into
> modules.ofmap as well as passed via environment variables for hotplug.
> As such, CRLF isn't really easiest choice to work with.

I don't think any value is "invalid". Not sure what is best to use ...
maybe '#' ? never seen it in there so far ... but who knows ...

> Is whitespace (in any form) allowed in the compatible value?

Yes. For example: "Power Macintosh" is a typical compatible value in the
root of the devive tree.

Maybe "tab" ?

Ben.


