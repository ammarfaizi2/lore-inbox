Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965369AbWJ2UCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965369AbWJ2UCh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965370AbWJ2UCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:02:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965369AbWJ2UCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:02:36 -0500
Date: Sun, 29 Oct 2006 12:02:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] UBD driver little cleanups for 2.6.19
Message-Id: <20061029120224.d25e3204.akpm@osdl.org>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2006 20:17:23 +0100
"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:

> Many cleanups for the UBD driver; these are mostly microfixes, I was waiting to
> finish and reorder also locking fixes (the code works, it is only to resplit,
> reproof-read and changelogs must be written) but I decided to send these ones
> for now. The rest will maybe be merged for 2.6.20.

None of this really looks like -rc3 material.  Why do you think it's
serious enough to justify late inclusion?

I'm not particularly fussed about UBD though - if you and Jeff particularly
want this lot in 2.6.19 then the world won't end.

"[PATCH 03/11] uml ubd driver: var renames" didn't apply due to
dummy_device_release not being present, which doesn't inspire confidence. 
What tree are you patching?

