Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWDXJXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWDXJXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 05:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWDXJXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 05:23:45 -0400
Received: from seldon.control.lth.se ([130.235.83.40]:25988 "EHLO
	seldon.control.lth.se") by vger.kernel.org with ESMTP
	id S932084AbWDXJXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 05:23:45 -0400
Message-ID: <444C991D.4010804@control.lth.se>
Date: Mon, 24 Apr 2006 11:23:41 +0200
From: Martin Andersson <martin.andersson@control.lth.se>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Re: [RFC][PATCH 5/9] CPU controller - Documents how the controller
 works
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > A better way to achieve the desired group cpu usage IMHO would be to
 > adjust nice level of members at slice refresh time.  This way, you get
 > the timeslice scaling and priority adjustment all in one.
 >
 > (I think I would do both actually, with nice level being preferred such
 > that dynamic priority spread within the group isn't flattened, which can
 > cause terminal starvation within the group, unless really required.)

I am actually working on something more or less like that as part of my 
licentiate (half time PhD) thesis. In the thesis I want to control CPU 
resources using a control theoretic approach. The results so far are 
very promising, but my code is not very mature yet. I plan to have my 
thesis ready during this summer, so if anyone is interested I can mail 
you a copy. If I have the time after that, I will try to incorporate my 
code into the CKRM framework.

/Martin Andersson
