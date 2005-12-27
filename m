Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVL0QDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVL0QDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 11:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVL0QDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 11:03:14 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:36025 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932314AbVL0QDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 11:03:14 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Gerhard Mack <gmack@innerfire.net>
Subject: Re: ati X300 support?
Date: Tue, 27 Dec 2005 16:03:30 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net> <200512271545.31224.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512271047260.2104@innerfire.net>
In-Reply-To: <Pine.LNX.4.64.0512271047260.2104@innerfire.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512271603.30939.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 December 2005 15:57, Gerhard Mack wrote:
> I have it working in X.org with no problem.  I just can't get the drm
> module working in the kernel.  Last time I tried to just add my PCI ids
> the problem was a lack of PCIE support in the drm drivers.

I'd try again, I have a vague memory of reading a changelog a few releases ago 
that mentioned PCIe support in radeon-drm.

> FYI the fglrx drivers suck badly.  ATI hasn't bothered to keep their
> drivers up to date at all and the result is that they finally have
> working 2.6.14 drivers but only for 32 bit machines.  x86_64 is still
> broken on any recent kernel and it's been that way for months.  ATI's tech
> support basically gave up after several days and just informed me it
> wasn't really supported and there is nothing they could do for me.

You're better off running open source drivers anyway, it's less hassle, you 
don't have to worry about every kernel upgrade breaking them, and it's only 
an X300 anyway -- on my Mobility 9600, I just play a few small games and 
expect OpenGL accelerated applications to work properly.

If your goals are similar, they're probably achievable with mainline.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
