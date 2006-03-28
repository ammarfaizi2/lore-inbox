Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWC1ET0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWC1ET0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 23:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWC1ET0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 23:19:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53377 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751141AbWC1ETZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 23:19:25 -0500
Date: Tue, 28 Mar 2006 15:19:31 +1100
From: David Chinner <dgc@sgi.com>
To: Don Dupuis <dondster@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops at __bio_clone with 2.6.16-rc6 anyone??????
Message-ID: <20060328041931.GI27189130@melbourne.sgi.com>
References: <632b79000603271917h4104049dh9b6b8251feac0437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632b79000603271917h4104049dh9b6b8251feac0437@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 09:17:03PM -0600, Don Dupuis wrote:
> I will get this oops during reboots. It doesn't happen everytime, but
> It happens on this system at least 1 to 2 out of 10 reboots. The
> machine is a Dell Powervault 745n. Here is the oops output:

Hmmm - I wonder if this is related to to this one:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114342655931507&w=2

which is an oops in the write path when dmcrypt is cloning a bio
from XFS.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
