Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUEFRlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUEFRlC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUEFRlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:41:02 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:32006 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261706AbUEFRk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:40:58 -0400
Date: Thu, 6 May 2004 19:41:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: imorgan@webcon.ca, helpdeskie@bencastricum.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 Sensors & USB problems
Message-Id: <20040506194128.50a37d13.khali@linux-fr.org>
In-Reply-To: <20040504203738.GJ24802@kroah.com>
References: <1081349796.407416a4c3739@imp.gcu.info>
	<Pine.LNX.4.58.0404171756400.11374@dark.webcon.ca>
	<Pine.LNX.4.58.0404171944160.11425@dark.webcon.ca>
	<20040418075140.6c118202.khali@linux-fr.org>
	<20040504203738.GJ24802@kroah.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not due to the complexity, it's just due to the fact that I
> haven't gotten around to doing it yet :)

OK, I should have stopped guessing and have taken a look to the code
instead.

> Patches to fix this are gladly welcome if the current situation really
> bothers people.  No userspace tools should have a problem with the way
> things are right now.  If they do have problems, please let me know.

You're right, there is no problem, at least no in "production"
environments. The only place where it is somewhat confusing (for
newcomers at least) is when probing the busses in the first time, or for
developers testing bus drivers (but those know what is happening).

At any rate, it is definitely better now than when device and
corresponding adapter could have different numbers. Of course it would
be better if device numbers were reused, but I'm not annoyed enough to
take a look right now either ;)

-- 
Jean Delvare
http://khali.linux-fr.org/
