Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131120AbQK3Ex5>; Wed, 29 Nov 2000 23:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131070AbQK3Exs>; Wed, 29 Nov 2000 23:53:48 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25872 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S129998AbQK3Evh>;
        Wed, 29 Nov 2000 23:51:37 -0500
Date: Wed, 29 Nov 2000 16:24:18 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Bonding...
Message-ID: <Pine.LNX.4.30.0011291619440.22577-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using ethernet bonding, does it divide the load between the
two based on connection, or packet by packet?  In other words, if
a single TCP connection were established between the two
machines, would it be twice as fast -using both cables for a
single file transfer lets say, or is it like SMP where it just
means you can have twice as many connections, and any given
connection would go only through a single cable, but multiple
traffic will be load balanced between both?






----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

#[Mike A. Harris bash tip #1 - separate history files per virtual console]
# Put the following at the bottom of your ~/.bash_profile
[ ! -d ~/.bash_histdir ] && mkdir ~/.bash_histdir
tty |grep "^/dev/tty[0-9]" >& /dev/null && \
        export HISTFILE=~/.bash_histdir/.$(tty | sed -e 's/.*\///')

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
