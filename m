Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVLTQrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVLTQrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVLTQrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:47:43 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:35478 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750792AbVLTQrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:47:42 -0500
Message-ID: <43A835D7.4090608@tmr.com>
Date: Tue, 20 Dec 2005 11:48:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [RFC] Let non-root users eject their ipods?
References: <1135047119.8407.24.camel@leatherman> <20051220074652.GW3734@suse.de> <1135082490.16754.0.camel@localhost.localdomain> <20051220132821.GH3734@suse.de> <1135085557.16754.2.camel@localhost.localdomain> <20051220133939.GI3734@suse.de>
In-Reply-To: <20051220133939.GI3734@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> There's still the quirky problem of forcing a locked tray out. In some
> cases this is what you want, if things get stuck for some reason or
> another. But usually the tray is locked for a good reason, because there
> are active users of the device.
> 
> Say two processes has the cdrom open, one of them doing io (maybe even
> writing!), the other could do a CDROMEJECT now and force the ejection of
> a busy drive.
> 
I think the whole area of permissions for locking the tray and doing 
eject need rethinking. I won't rehash what I have said before, that if I 
have write permission growisofs should be able to lock the tray.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
