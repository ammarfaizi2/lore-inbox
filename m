Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVFIB6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVFIB6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 21:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVFIB6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 21:58:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36737 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261514AbVFIB6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 21:58:39 -0400
Subject: Re: 2.6.12-rc6-mm1
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0506071659580.30849@schroedinger.engr.sgi.com>
References: <1004450000.1118188239@flay>
	 <20050607165656.2517b417.akpm@osdl.org>
	 <Pine.LNX.4.62.0506071659580.30849@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 21:58:56 -0400
Message-Id: <1118282337.6247.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 17:02 -0700, Christoph Lameter wrote:
> On Tue, 7 Jun 2005, Andrew Morton wrote:
> 
> > > Diffprofile is wacko (HZ seems to be defaulting to 250 in -mm).
> > 
> > Oh crap, so it does.  That's wrong.
> 
> Email by you and Linus indicated that 250 should be the default.

Wait, does that mean the default HZ is going to be changed in the 2.6.x
timeframe?  That's a big user-visible regression, as it makes the
sleep() resolution worse, and would force apps with tight timing
requirements to go back to using the RTC like on 2.4.

Unless, of course, the plan is to merge the high-res timers patch at the
same time.

Lee

