Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWDHTvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWDHTvM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 15:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWDHTvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 15:51:11 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54663 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751418AbWDHTvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 15:51:11 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <443813C4.9090000@s5r6.in-berlin.de>
Date: Sat, 08 Apr 2006 21:49:24 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Dan Dennedy <dan@dennedy.org>
CC: linux1394-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       scjody@modernduck.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] the overdue removal of RAW1394_REQ_ISO_{LISTEN,SEND}
References: <20060406224706.GD7118@stusta.de> <44374FC0.3070507@s5r6.in-berlin.de> <200604081218.24544.dan@dennedy.org>
In-Reply-To: <200604081218.24544.dan@dennedy.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.847) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Dennedy wrote:
> Kino still uses the legacy raw1394 iso interface for capture by default; 
> however, it can also still use dv1394. I will accellerate the adoption of the 
> new raw1394 interface since I have already done this for dvgrab 2.0. 
> Cinelerra supports libiec61883 now.
> 
> Unfortunately, gstreamer still uses legacy raw1394 iso interface, but I can 
> nag someone at Fluendo. I think another high profile app that might be 
> affected is GnomeMeeting/Ekiga, but I have not kept close track of it.
> 
> Also, I have not released a version of libraw1394 that contains the 
> deprecation warnings, but I can do so this weekend. And then another release 
> when the removed kernel interfaces are released that removes the functions. 

Then I suggest we adjust the date in 
Documentation/feature-removal-schedule.txt (increment by 1 year?) and 
also list kino and gstreamer as affected application programs there.

It appears from grep'ing through the sources of Ekiga 2.0.1 that it does 
not access (lib)raw1394 by itself.
-- 
Stefan Richter
-=====-=-==- -=-- -=---
http://arcgraph.de/sr/
