Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWGMW44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWGMW44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWGMW44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:56:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:62699 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161031AbWGMW4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:56:55 -0400
Subject: Re: [BUG] no sound on ppc mac mini
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1152821370.6845.9.camel@localhost>
References: <1152821370.6845.9.camel@localhost>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 08:55:09 +1000
Message-Id: <1152831309.23037.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 13:09 -0700, john stultz wrote:
> Using the current 2.6.18-rc1-git, I'm finding no sound card being
> detected on my mac mini.
> 
> I looked through the config and saw the new AOA option w/ the Toonie
> chip under it, and I enabled it. However, I still get no sound card
> detected. I tried enabling the "layout-id fabric" option, but I got a
> panic on boot (I can try to get a photo later if necessary).
> 
> Any thoughts? 

Is this really a current git or an -rc1 snapshot ? The crashes on boot
should have been fixed ... unless there is another problem on the mac
mini. Can you try having them as modules instead ?

Cheers,
Ben.


