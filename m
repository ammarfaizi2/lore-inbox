Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWIHQIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWIHQIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWIHQIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:08:16 -0400
Received: from web36612.mail.mud.yahoo.com ([209.191.85.29]:62303 "HELO
	web36612.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750826AbWIHQIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:08:15 -0400
Message-ID: <20060908160814.64210.qmail@web36612.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Fri, 8 Sep 2006 09:08:14 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
To: linux-kernel@vger.kernel.org
In-Reply-To: <20060908104550.GA920@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




There is lots of talk regarding the interaction
between setuid and capabilities. While the
current semanitics that lack file system
support include (of necessity) interaction
the intent of the POSIX scheme completely
divorces the setuid mechanism from the
capability scheme. The intention on a system
that supports file system capabilities is
that the setuid bit is a ignored in the
capability calculation, allowing for a system
on which root is just another user. The
capability inheritance machanism is
complicated, but that is in support of
the ability to mark a program with a limited
set of privilege so that setuid root need
not be used.

Does anyone need a pointer to the POSIX
draft document? They include extensive if
somewhat disjointed rationale sections.

http://wt.tuxomania.net/publications/posix.1e/download.html



Casey Schaufler
casey@schaufler-ca.com
