Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262001AbTCQW51>; Mon, 17 Mar 2003 17:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTCQW51>; Mon, 17 Mar 2003 17:57:27 -0500
Received: from ns0.cobite.com ([208.222.80.10]:61445 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S262001AbTCQW5U>;
	Mon, 17 Mar 2003 17:57:20 -0500
Date: Mon, 17 Mar 2003 18:08:11 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <Pine.LNX.4.44.0303171804010.23829-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea,

FWIW, I have already written a program called cvsps (www.cobite.com/cvsps) 
which extracts 'patchset' information from cvs log output.  

Currently, this program doesn't work with the bk-cvs because the log 
messages that are committed with each file in a changeset can be 
different, and cvsps assumes the log message will  be the same.  

However, about a 5 line hack to my program (in progress) will allow it to 
recreate the ChangeSet information, since Larry has promised that the 
timestamps of all files touched by a changeset will be unique.

This might help you out.  I'll let you know when the '--bk-cvs' option has 
been implemented ;-)

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

