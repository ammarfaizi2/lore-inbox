Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbUKQQ7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbUKQQ7w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUKQQ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:58:38 -0500
Received: from zamok.crans.org ([138.231.136.6]:41916 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262405AbUKQQzy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:55:54 -0500
To: Vladimir Saveliev <vs@namesys.com>
Cc: reiserfs-list@namesys.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2-mm1: oops when accessing reiser4 fs's (maybe fix provided)
References: <874qjptyl1.fsf@barad-dur.crans.org>
	<1100675389.1399.27.camel@tribesman.namesys.com>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Wed, 17 Nov 2004 17:55:51 +0100
In-Reply-To: <1100675389.1399.27.camel@tribesman.namesys.com> (Vladimir
	Saveliev's message of "Wed, 17 Nov 2004 10:09:49 +0300")
Message-ID: <87d5ycza7c.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev <vs@namesys.com> disait dernièrement que :

> Hello
>
> On Tue, 2004-11-16 at 21:53, Mathieu Segaud wrote:
>> I tried 2.6.10-rc2-mm1 and the last reiser4 updates gave some (many many)
>> oopses flooding my screen :).
>> I tried reverting reiser4-fix-deadlock.patch and oopses are gone.
>> 
> Would you please instead try the attached patch? 

yep.
indeed it worked
anyway, for the quick answer

>
>> I tried this one because thru the quick traces on my screen, I saw a reference
>> to get_current_context.
>> The speed of the traces and the unasibility of the box prevented me from
>> making differences between "real" oopses and BUG_ON(), sorry for that...
>> 
>> If you want some traces I can provide them ASAP (e.g. tomorrow)
>
>
>
>

-- 
Carrots work on rabbits, they don't work on hungry weasels.

	- Alan Cox on linux-kernel

