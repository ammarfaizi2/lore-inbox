Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbULGNZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbULGNZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 08:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbULGNZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 08:25:47 -0500
Received: from mini002.webpack.hosteurope.de ([80.237.130.131]:6094 "EHLO
	mini002.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261809AbULGNZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 08:25:43 -0500
From: "cr7" <cr7@darav.de>
To: linux-kernel@vger.kernel.org
Cc: justin.piszcz@mitretek.org
Subject: RE: FS Corruption [Re: Linux 2.6.10-rc3]
Date: Tue, 07 Dec 2004 15:07:17 +0100
Message-ID: <elmo110242843711331446504142@debian>
User-Agent: elmo/1.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I also got the FS corruption when trying "rm -f ..." as descripted.
Filesystems affected: Reiser4 and ext3.

But I'm using kernel 2.6.10-rc2-mm4 - so a patch moved from -mm into -rc3 seems to be responsible for that problem.
A candidate might be: "fix-an-xfs-direct-i-o-deadlock.patch" found in -mm4 and gone into -rc3.

Sorry, I can't test now if this patch is responsible (I'm not at home).
But may be someone else can do.

Regards,
Carsten




