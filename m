Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTL2NhV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 08:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTL2NhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 08:37:21 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:36430 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263464AbTL2NhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 08:37:20 -0500
Message-ID: <3FF02BA5.2080809@myrealbox.com>
Date: Mon, 29 Dec 2003 05:27:01 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031226
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 had good mouse-support, why is 2.6 so bad?
References: <fa.l7jjj9n.1n66tjf@ifi.uio.no> <fa.fmguq42.vj43qe@ifi.uio.no> <3fefe3ed$0$9748$edfadb0f@dread14.news.tele.dk>
In-Reply-To: <3fefe3ed$0$9748$edfadb0f@dread14.news.tele.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Michael Jensen wrote:
> Yes with psmouse_noext the wheel stops to work completely and xev does 
> not detect anything when I use the wheel.

There were some changes committed just a few hours ago which might fix it.

The psmouse_noext parameter has been replaced by psmouse_proto which is
what you might want to try.  I'm about to try it myself on the one
machine I have problems with.

The patches are here:
http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/
(click on Full Patch Set from v2.6.0)


