Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132006AbRCYOuR>; Sun, 25 Mar 2001 09:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132008AbRCYOuG>; Sun, 25 Mar 2001 09:50:06 -0500
Received: from [195.63.194.11] ([195.63.194.11]:2055 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S132006AbRCYOty>;
	Sun, 25 Mar 2001 09:49:54 -0500
Message-ID: <3ABE0292.9EEDE4BD@evision-ventures.com>
Date: Sun, 25 Mar 2001 16:37:06 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Stephen Satchell <satch@fluent-access.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <4.3.2.7.2.20010324214339.00b228a0@mail.fluent-access.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Satchell wrote:
> 
> At 12:41 AM 3/25/01 +0100, you wrote:
> >If your box is running for example a mail server, and it appears that
> >another process is juste eating the free memory, do you really want to kill
> >the mail server, just because it's the main process and consuming more
> >memory and CPU than others?
> >
> >Well, fine, your OS is up, but your application is not here anymore.
> 
> If you have a mission-critical application running on your box, add it to
> the inittab file with the RESPAWN attribute.  That way, OOM killer kills
> it, init notices it, and init restarts your server.

That makes me actually rolling on by back... Just try to add oracle to
inittab
crash it and watch it grabefully restarting by repawn!!!!!!!!!

> By the way, are the people working on the OOM-killer also working to avoid
> killing task 1?

Already done.
