Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbSJLQfX>; Sat, 12 Oct 2002 12:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbSJLQfX>; Sat, 12 Oct 2002 12:35:23 -0400
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:6919 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S261284AbSJLQfQ>; Sat, 12 Oct 2002 12:35:16 -0400
To: "Murray J. Root" <murrayr@brain.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 ieee1394 won't build
References: <20021012090040.GA11816@Master.Wizards>
From: Kristian Hogsberg <hogsberg@users.sf.net>
Date: 12 Oct 2002 18:40:59 +0200
In-Reply-To: <20021012090040.GA11816@Master.Wizards>
Message-ID: <m3zntj8vac.fsf@DK300KRH.bang-olufsen.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.9 |November
 16, 2001) at 12-10-2002 18:40:59,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.9 |November 16, 2001) at
 12-10-2002 18:41:06,
	Serialize complete at 12-10-2002 18:41:06
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Murray J. Root" <murrayr@brain.org> writes:

> make -f drivers/ieee1394/Makefile 
[... errors]

This is because of the workqueue cleanup.  There's a fix in the
ieee1394 SVN repository which haven't been synced with Linus yet.  You
can get a tar.gz of the latest drivers from www.linux1394.org.

Kristian


