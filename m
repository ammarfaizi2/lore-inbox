Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUJRSVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUJRSVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUJRSOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:14:40 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:22885 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267164AbUJRSLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:11:06 -0400
Subject: Re: 2.6.9-rc3 and rc4: parallel printer has gone
From: Paul Fulghum <paulkf@microgate.com>
To: T.Maguin@web.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200410181951.57758.T.Maguin@web.de>
References: <200410171218.23232.T.Maguin@web.de>
	 <200410181951.57758.T.Maguin@web.de>
Content-Type: text/plain
Message-Id: <1098123062.3251.10.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 18 Oct 2004 13:11:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 12:51, Thomas Maguin wrote:
> The parallel printer disappears from 2.6.9-rc2 to rc4. 
> 
> lp: driver loaded but no devices found
> 
> The rc-1 and rc4-mm1 versions are ok. 

It looks like the patch from Olaf Hering <olh@suse.de>
http://www.ussg.iu.edu/hypermail/linux/kernel/0408.0/0792.html
causes the problem.

A patch from Andrea Arcangeli <andrea@novell.com>
http://www.ussg.iu.edu/hypermail/linux/kernel/0409.3/1515.html
corrects the problem.

It looks like the Linus tree only has Olaf's patch.
Andrew's tree (mm) has Andrea's patch.

-- 
Paul Fulghum
paulkf@microgate.com

