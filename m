Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUEPRcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUEPRcO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUEPRcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:32:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:34447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264129AbUEPRcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:32:12 -0400
Date: Sun, 16 May 2004 10:29:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] "bk pull" does not update my sources...?
Message-Id: <20040516102936.0c0df511.rddunlap@osdl.org>
In-Reply-To: <40A7A145.5020201@g-house.de>
References: <40A51CFB.7000305@g-house.de>
	<c85lk9$96j$1@sea.gmane.org>
	<40A7A145.5020201@g-house.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 May 2004 19:13:41 +0200 Christian Kujau <evil@g-house.de> wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| walt schrieb:
| |> evil@sheep:/usr/src/linux-2.6-BK$ head -n5 Makefile
| |> VERSION = 2
| |> PATCHLEVEL = 6
| |> SUBLEVEL = 6
| |> EXTRAVERSION =
| |
| | This is correct.  Linus does not include the 'bk' in the 'extraversion'
| | field.
| 
| so, the Makefile from the -bk snapshots (e.g. patch-2.6.6-bk1.bz2) was
| edited and will show an EXTRAVERSION of "-bk1", while the original
| Makefile does not? this is insane!

Right.  The bk tree does not contain -bkN or anything in the
EXTRAVERSION string.  The bk snapshots do add that string.

I don't find it hard to keep them separated, but, yeah, that's the
way it is.

--
~Randy
