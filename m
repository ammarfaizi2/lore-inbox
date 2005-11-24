Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbVKXV0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbVKXV0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 16:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbVKXV0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 16:26:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:58605 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932658AbVKXV0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 16:26:53 -0500
Subject: Re: [PATCH] Fix USB suspend/resume crasher
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <200511242214.16365.rjw@sisk.pl>
References: <1132715288.26560.262.camel@gaston>
	 <200511242150.23205.rjw@sisk.pl> <1132866088.26560.455.camel@gaston>
	 <200511242214.16365.rjw@sisk.pl>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 08:22:22 +1100
Message-Id: <1132867342.26560.461.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> FWIW, does the appended change look reasonable to you?  (It apparently
> helps. ;-))

Yes. I was about to do a new patch after I finish my breakfast, but
yours applied on top of Greg's merged one works too.

Ben.


