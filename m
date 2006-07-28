Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWG1BKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWG1BKn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 21:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWG1BKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 21:10:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26245 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751035AbWG1BKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 21:10:42 -0400
Date: Thu, 27 Jul 2006 21:10:40 -0400
From: Dave Jones <davej@redhat.com>
To: Patrick McFarland <diablod3@gmail.com>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: The ondemand CPUFreq code -- I hope the functionality stays
Message-ID: <20060728011040.GO5687@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Patrick McFarland <diablod3@gmail.com>,
	Miles Lane <miles.lane@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <a44ae5cd0607270154p50c2c7fcx734bfea026dc69a9@mail.gmail.com> <200607272104.24088.diablod3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607272104.24088.diablod3@gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 09:04:23PM -0400, Patrick McFarland wrote:

 > I think you've gotten confused. Ondemand is a horrible governor that only 
 > flips between two cpu frequencies, the lowest and the highest.

That isn't true.  I just double checked, and saw my core-duo changing
between all 4 states it offers.

 > Use the Conservative governor instead.

This governor is based on the same code as on-demand with some subtle
tweaks to make it not change the frequency as often.  If anything *this*
one should be less 'active' for you than ondemand.

What driver are you using ?

		Dave

-- 
http://www.codemonkey.org.uk
