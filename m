Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAILYb>; Tue, 9 Jan 2001 06:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129641AbRAILYM>; Tue, 9 Jan 2001 06:24:12 -0500
Received: from www.lahn.de ([213.61.112.58]:19572 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S129610AbRAILYB>;
	Tue, 9 Jan 2001 06:24:01 -0500
Date: Tue, 9 Jan 2001 12:22:09 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: pmhahn@titan.lahn.de
To: "Sean R. Bright" <elixer@erols.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FS callback routines
In-Reply-To: <000c01c079db$78ab39e0$59aa0141@cc230545b>
Message-ID: <Pine.LNX.4.21.0101091220320.4946-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Sean R. Bright wrote:

> I was writing a user space application to monitor a folder's contents.  The
> folder itself contained 100 folders, and each of those contained 24 folders.
> While writing the code to traverse the directory structure I realized that
> instead of my software figuring out when things change, why not just have
> the fs tell my application when something was updated.  For example, say we
> had a function called watch_fs(), that took an inode reference and a
> function pointer and maybe a bitmask of events to watch for.  When that
> inode (or its children) were changed, why couldn't the fs code call the
> callback function I specified?
RFTM: linux-2.4.0/Documentation/dnotify.txt

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
