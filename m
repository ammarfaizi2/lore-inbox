Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTL3Ete (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTL3Ete
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:49:34 -0500
Received: from dp.samba.org ([66.70.73.150]:25262 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264451AbTL3Et3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:49:29 -0500
Date: Tue, 30 Dec 2003 13:28:40 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 modules, hotplug, PCMCIA
Message-Id: <20031230132840.4a8d88b4.rusty@rustcorp.com.au>
In-Reply-To: <173b01c3cceb$05ade850$43ee4ca5@DIAMONDLX60>
References: <173b01c3cceb$05ade850$43ee4ca5@DIAMONDLX60>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003 11:33:04 +0900
"Norman Diamond" <ndiamond@wta.att.ne.jp> wrote:

> Sorry I am not copying the dozens of error messages from
> ./generate-modprobe.conf, but anyone with SuSE 8.2 can reproduce them.

Yes, it's kind of noisy.  I've put some silencers on it for the next release.

> When
> there was no improvement, I looked at the instructions in the FAQ.  I'm not
> running RedHat and I did upgrade to later than 0.9.9.  But things still
> don't load properly, for which the second answer in the FAQ recommends using
> non-existent file "generate-module.conf".  Presumably if that command
> existed then it would overwrite the existing /etc/module.conf file.  So I
> only obeyed the README not the FAQ.

I've fixed this too.  You've already done it as part of the README.

Good luck...
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
