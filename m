Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTJETnG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTJETnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:43:06 -0400
Received: from zero.aec.at ([193.170.194.10]:45319 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263807AbTJETnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:43:04 -0400
To: "Breno" <brenosp@brasilsec.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Freeing unused kernel memnory - bug
From: Andi Kleen <ak@muc.de>
Date: Sun, 05 Oct 2003 21:42:45 +0200
In-Reply-To: <Dkyr.4PZ.1@gated-at.bofh.it> ("Breno"'s message of "Sun, 05
 Oct 2003 19:10:07 +0200")
Message-ID: <m3d6dbbhe2.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <Dkyr.4PZ.1@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Breno" <brenosp@brasilsec.com.br> writes:

> Hi ,
>
> I´m using 2.4.22 and when i reboot my system , the boot process stop when
> "freeing unused memory" message appear.
>
> What can be ?

It's failing when the kernel first enters user space.

This often happens after a miscompilation, e.g. when some files are
not uptodate. Do a make distclean and try again.

-Andi
