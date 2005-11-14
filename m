Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVKNMf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVKNMf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVKNMf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:35:56 -0500
Received: from cantor2.suse.de ([195.135.220.15]:47572 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751109AbVKNMfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:35:55 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [discuss] Re: [PATCH 5/39] NLKD/x86-64 - early/late CPU up/down notification
Date: Mon, 14 Nov 2005 13:37:14 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43720DAE.76F0.0078.0@novell.com> <200511101410.16903.ak@suse.de> <43785304.76F0.0078.0@novell.com>
In-Reply-To: <43785304.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511141337.14365.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 November 2005 09:04, Jan Beulich wrote:

> Assuming you mean CPU_ONLINE and CPU_DEAD. 

Yes

> But no, I don't really like 
> this. The most significant difference is that the existing notifications
> are not sent on the starting CPU, but on the one it got started from.
> The point in time is only the second reason for not using these.

Ok, I can see your point. Let's say a new notifier for that would
be ok if you can find at least one other existing in tree user and 
convert it  to it. Does that sound fair? 

Note I'm about to remove the IO apic watchdog setup, so that one
doesn't count.

-Andi
