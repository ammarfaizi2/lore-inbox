Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267656AbTAHBvC>; Tue, 7 Jan 2003 20:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267653AbTAHBuP>; Tue, 7 Jan 2003 20:50:15 -0500
Received: from b.smtp-out.sonic.net ([208.201.224.39]:60568 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S267651AbTAHBtW>; Tue, 7 Jan 2003 20:49:22 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Tue, 7 Jan 2003 17:58:01 -0800
From: dhinds <dhinds@sonic.net>
To: Joshua Kwan <joshk@ludicrus.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.54-dj1-bk] Some interesting experiences...
Message-ID: <20030107175801.A23794@sonic.net>
References: <20030107172147.3c53efa8.joshk@ludicrus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030107172147.3c53efa8.joshk@ludicrus.ath.cx>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 05:21:46PM -0800, Joshua Kwan wrote:

> 2. [linux-2.5] pcmcia-cs 3.2.3 will no longer build: here is the build
> log, pertinent details only.
> 
> cc  -MD -O3 -Wall -Wstrict-prototypes -pipe -Wa,--no-warn
> -I../include/static -I/usr/src/linux-2.5/include -I../include
> -I../modules -c cardmgr.c
> In file included from cardmgr.c:200:
> /usr/src/linux-2.5/include/scsi/scsi.h:185: parse error before "u8"

This should be fixed in the current beta for 3.2.4 available from
http://pcmcia-cs.sourceforge.net/ftp/NEW.

-- Dave
