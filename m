Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTGUGhG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 02:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTGUGhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 02:37:06 -0400
Received: from [203.94.130.164] ([203.94.130.164]:63177 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S263205AbTGUGhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 02:37:04 -0400
Message-ID: <46349.203.113.198.161.1058770320.squirrel@bad-sports.com>
In-Reply-To: <0c1801c34f50$a9706800$64ee4ca5@DIAMONDLX60>
References: <0c1801c34f50$a9706800$64ee4ca5@DIAMONDLX60>
Date: Mon, 21 Jul 2003 16:52:00 +1000 (EST)
Subject: Re: Tried to run 2.6.0-test1
From: "Brett" <generica@email.com>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Reply-To: generica@email.com
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond said:
> Again I cannot keep up with the mailing list.  If anyone wishes to advise
> or
> has questions, please kindly contact me directly.
>
> By the way, the last line in that README file says that if this is all too
> complicated then install the source RPM.  Gee thanks.  I already tried
> "rpm --rebuild" but it assumes an i686.
>

you want rpmbuild

[brett@synapse brett]$ rpmbuild --help
Usage: rpmbuild [OPTION...]
<snip>
  --target=CPU-VENDOR-OS        override target platform

rpmbuild --target=i586 --rebuild modutils-*.src.rpm

thanks,

     / Brett
