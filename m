Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWBIRY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWBIRY2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWBIRY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:24:27 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40895 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932495AbWBIRY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:24:26 -0500
Date: Thu, 9 Feb 2006 18:24:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH GIT] drivers/block/ub.c - misc. cleanup/indentation,
 removed unneeded return
In-Reply-To: <20060208194057.55b02719.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.61.0602091823310.30108@yvahk01.tjqt.qr>
References: <mailman.1139418724.17734.linux-kernel2news@redhat.com>
 <20060208194057.55b02719.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I created this little patch while reading through drivers/block/ub.c. It fixes
>> some indentation/whitespace as well as some empty commenting, an hardcoded
>> module name and an unneeded return.
>
>I strongly disagree.
>
>But the rest is quite bad, the worst being indenting the switch statement.
>
switch(a) {
case A:
    dosomething;
    break;
}

Now what if

switch(a) {
case A: {
    int tmp;
    do_something;
    break;
}
}


Jan Engelhardt
-- 
