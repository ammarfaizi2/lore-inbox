Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTFNWA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 18:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTFNWA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 18:00:26 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:957 "EHLO mauve.demon.co.uk")
	by vger.kernel.org with ESMTP id S261280AbTFNWAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 18:00:25 -0400
From: root@mauve.demon.co.uk
Message-Id: <200306142209.XAA17516@mauve.demon.co.uk>
Subject: Re: reading links in proc - permission denied
To: linux-newbie@tlinx.org (linda w.)
Date: Sat, 14 Jun 2003 23:09:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000b01c332b7$44c68250$1403a8c0@sc.tlinx.org> from "linda w." at Jun 14, 2003 01:55:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ---
> 	Not at all...in fact was told it doesn't.  Apparently, though,
> the listed permissions on the links are arbitrary and the system
> fairly well ignores them.
> 
> 	I vaguely remember someone once saying that even if a symlink
> had permissions lrxw------, it could still be used by group and
> others.  I don't know if that was or is still true -- certainly doesn't

man symlink
...
       The permissions of a symbolic  link  are  irrelevant;  the
       ownership  is  ignored  when  following  the  link, but is
       checked when removal or renaming of the link is  requested
       and the link is in a directory with the sticky bit set.

In short, the permissions of the file being linked to are important.
