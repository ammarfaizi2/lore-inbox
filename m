Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWCXQVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWCXQVJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWCXQVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:21:09 -0500
Received: from web37710.mail.mud.yahoo.com ([209.191.87.108]:2437 "HELO
	web37710.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932412AbWCXQVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:21:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kQDHghEvuqY3wMRG65HLaVqQ08dX6BdgUmrF/qRwNyqRO201t6qzjGOHcsApaWp1mSFxdOkzo3sOY1zod5bxBz2hVjyzCdnF+fgrrFj6Djb3u4BDsYyM+ZAJ20daZRogXDRA6pHA5xY3sXmWN657vGmA7JuQucezMlIz9XlJack=  ;
Message-ID: <20060324162107.50804.qmail@web37710.mail.mud.yahoo.com>
Date: Fri, 24 Mar 2006 08:21:07 -0800 (PST)
From: Edward Chernenko <edwardspec@yahoo.com>
Subject: [PATCH 2.6.15] Adding kernel-level identd dispatcher
To: linux-kernel@vger.kernel.org
Cc: edwardspec@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ident daemon to net/gnuidentd/
directory.
Apply to: 2.6.15.1.
Patch is here:
http://unwd.sourceforge.net/gnuidentd-2.6.15.patch

I used two threads: one for connections handling and
another for tracking /etc/passwd changes through
inotify.
Additionally, root can set users hiding rules using
file in /proc. 

I'm awaiting your notes/tips.
Please CC me to <edwardspec@gmail.com>

Signed-Off-by: Edward Chernenko <edwardspec@gmail.com>


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
