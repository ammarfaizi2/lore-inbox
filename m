Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbTADXBz>; Sat, 4 Jan 2003 18:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbTADXBz>; Sat, 4 Jan 2003 18:01:55 -0500
Received: from mailhost.bonet.ac ([194.165.224.191]:33425 "EHLO
	mailhost.bonet.ac") by vger.kernel.org with ESMTP
	id <S261693AbTADXBz>; Sat, 4 Jan 2003 18:01:55 -0500
From: "Alfred M. Szmidt" <ams@kemisten.nu>
To: schottelius@wdt.de
CC: bug-fileutils@gnu.org, linux-kernel@vger.kernel.org
In-reply-to: <20030104113901.GB255@schottelius.org> (message from Nico
	Schottelius on Sat, 4 Jan 2003 12:39:01 +0100)
Subject: Re: bugs in df [problem of fileutils or kernel?]
References: <20021231141036.GA494@schottelius.org> <E18TRt6-0004wx-00@lgh163a.kemisten.nu> <20030104113901.GB255@schottelius.org>
Message-Id: <E18UxQl-0001m5-00@lgh163a.kemisten.nu>
Date: Sun, 05 Jan 2003 00:10:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   nice,1002 lines of code in df.c.. okay, let's have a look into it...
   (currently I think it _could_ be a kernel bug, so I will pass this message
   alon to lkml)

There is no reason why you should read all of df.c, you can use the
GNU Debugger and see what is going on quickly.  Possible places to set
break points might be in [coreutils]/src/df.c:show_dev and/or
[coreutils]/lib/fsusage.c:get_fs_usage.

