Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbULGAIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbULGAIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbULGAIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:08:23 -0500
Received: from mta.itasoftware.com ([63.107.91.101]:59025 "EHLO
	mta.internal.itasoftware.com") by vger.kernel.org with ESMTP
	id S261706AbULGAHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:07:48 -0500
Message-ID: <41B4F447.2060808@ccs.neu.edu>
Date: Mon, 06 Dec 2004 19:07:35 -0500
From: Johan <johan@ccs.neu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: status of via velocity in 2.6.9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How 'working' are the via velocity drivers in 2.6.9?

For better or worse, the cheapest gigabit card I could find has the 
vt6122 chip, which seems to want the velocity drivers. (*)

Unfortunately, while they (the driver and card, that is) seem at first 
to work fine, auto negotiating a gigabit connection with my hub, the 
network stops working after 5 ish minutes (could be function of bytes 
tx'ed as well, I guess). restarting the network (appart from a kernel 
upgrade, the box is redhat fc2) fixes the problem... for another 5 minutes.

Is this known behavior?

Thanks

Johan

(*) The card's box advertizes linux compatibility with RH 7.3 (2.4.18-3 
or later), which makes me wonder whether another driver may work better. 
  2.4.18-3 would seem to predate the via-velocity driver.



