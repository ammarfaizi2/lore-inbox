Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTIKCmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 22:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTIKCmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 22:42:54 -0400
Received: from dp.samba.org ([66.70.73.150]:14764 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264231AbTIKCmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 22:42:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module 
In-reply-to: Your message of "Thu, 11 Sep 2003 00:32:47 +0100."
             <20030911003247.V30046@flint.arm.linux.org.uk> 
Date: Thu, 11 Sep 2003 12:04:35 +1000
Message-Id: <20030911024252.B26352C04D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030911003247.V30046@flint.arm.linux.org.uk> you write:
> On Tue, Sep 09, 2003 at 03:24:21PM -0700, Greg KH wrote:
> > A while ago we had talked about adding a kobject to struct module.  By
> > doing this we add support for module paramaters and other module info to
> > be exported in sysfs.  So here's a patch that does this that is against
> > 2.6.0-test4 (it applies with some fuzz, sorry.)
> 
> Please excuse my short-sightedness, but I think the following points
> haven't been thought deeply enough:

Well, obviously not publically enough, at least 8(.

To clarify: this is for new-style module params, which explicitly
control their own visibility with the perm arg.

One more reason for module authors to switch 8)

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
