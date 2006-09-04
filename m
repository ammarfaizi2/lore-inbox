Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWIDHXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWIDHXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWIDHXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:23:15 -0400
Received: from gw.goop.org ([64.81.55.164]:60125 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932440AbWIDHXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:23:13 -0400
Message-ID: <44FBD462.1040902@goop.org>
Date: Mon, 04 Sep 2006 00:23:14 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 08/22][RFC] Unionfs: Directory manipulation helper functions
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014708.GI5788@fsl.cs.sunysb.edu> <Pine.LNX.4.61.0609040907110.9108@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0609040907110.9108@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> +	if (0 <= bopaque && bopaque < bend)
>>     
>
> Turn it. Constant values are usually wanted on the right side.
>
> 	bopaque >= 0

Not in this case.  The test in its current form clearly shows that 
bopaque needs to be within a range.


    J

-- 
VGER BF report: H 0
