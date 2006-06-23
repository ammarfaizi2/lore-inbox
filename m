Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWFWPjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWFWPjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWFWPjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:39:09 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:12725 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751244AbWFWPjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:39:05 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] get USB suspend to work again on 2.6.17-mm1
Date: Fri, 23 Jun 2006 08:38:57 -0700
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org,
       linux-kernel@vger.kernel.org, Mattia Dongili <malattia@linux.it>,
       pavel@suse.cz, Jiri Slaby <jirislaby@gmail.com>
References: <Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606230838.57957.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 June 2006 7:51 am, Alan Stern wrote:

> Ah, there's the rub.  If a driver doesn't have suspend/resume methods, is 
> it because it doesn't need them, or is it because nobody has written them 
> yet?  In the latter case, failing the suspend or unbinding the driver are 
> the only safe courses.

I think the former would ba a dangerous assumption ... in the category
of "intermittent bugs triggering later on" rather than "easily reproduced
bugs triggering right at the trouble spot" (like the latter).

- Dave
