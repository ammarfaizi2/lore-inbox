Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVHYXxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVHYXxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 19:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVHYXxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 19:53:55 -0400
Received: from vena.lwn.net ([206.168.112.25]:63653 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1751074AbVHYXxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 19:53:54 -0400
Message-ID: <20050825235354.10376.qmail@lwn.net>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Jonathan Corbet <corbet@lwn.net>, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] drivers/hwmon/*: kfree() correct pointers 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 26 Aug 2005 00:02:31 +0200."
             <20050826000231.35b97af9.khali@linux-fr.org> 
Date: Thu, 25 Aug 2005 17:53:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Already fixed in Greg's i2c tree and -mm for quite some time now...

So it is.  The comment says, however, that "the existing code works
somewhat by accident."  In the case of the 9240 driver, however, the
existing code demonstrably does not work - it oopsed on me.  The patch
in Greg's tree looks fine (it's a straightforward fix, after all); I'd
recommend that it be merged before 2.6.13.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net

