Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUEOAKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUEOAKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbUEOAIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:08:02 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:61435 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264660AbUEOAHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:07:08 -0400
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, Andy Lutomirski <luto@stanford.edu>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] scaled-back caps, take 4
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40A4F163.6090802@stanford.edu>
	<20040514110752.U21045@build.pdx.osdl.net>
	<200405141548.05106.luto@myrealbox.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 15 May 2004 02:06:57 +0200
In-Reply-To: <200405141548.05106.luto@myrealbox.com> (Andy Lutomirski's
 message of "Fri, 14 May 2004 15:48:04 -0700")
Message-ID: <87hduisgda.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> writes:

> cap_2.6.6-mm2_4.patch: New stripped-back capabilities.
>
>  fs/exec.c               |   15 ++++-
>  include/linux/binfmts.h |    9 ++-
>  security/commoncap.c    |  130 ++++++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 136 insertions(+), 18 deletions(-)
[patch]

Why don't you provide this as a configurable andycap.c module?
I think, this is the whole point of LSM.

Regards, Olaf.
