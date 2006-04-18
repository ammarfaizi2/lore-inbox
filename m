Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWDRXJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDRXJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWDRXJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:09:32 -0400
Received: from web36612.mail.mud.yahoo.com ([209.191.85.29]:43360 "HELO
	web36612.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750809AbWDRXJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:09:31 -0400
Message-ID: <20060418230931.40039.qmail@web36612.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 18 Apr 2006 16:09:31 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Crispin Cowan <crispin@novell.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <1145391969.21723.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> ... A file name is a pretty
> meaningless object in Unixspace ...

Stephen is right that the inode is the object.
Crispin is right that people care about path names.

The linux-audit folks have been hashing this
about good and hard. It is true that both the
pathname /etc/shadow and the inode it represents
are interesting from various secuirty viewpoints.
If you insist on either being the definitive
security referent you will be wrong about half
the time.


Casey Schaufler
casey@schaufler-ca.com
