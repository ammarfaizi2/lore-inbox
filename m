Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268044AbTGUGw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 02:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbTGUGw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 02:52:59 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:39360 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S268044AbTGUGw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 02:52:58 -0400
Message-ID: <0c4e01c34f56$b2b95ce0$64ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <generica@email.com>
Cc: <linux-kernel@vger.kernel.org>
References: <0c1801c34f50$a9706800$64ee4ca5@DIAMONDLX60> <46349.203.113.198.161.1058770320.squirrel@bad-sports.com>
Subject: Re: Tried to run 2.6.0-test1
Date: Mon, 21 Jul 2003 16:06:32 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brett" <generica@email.com> replied to one of my desperate messages today.
I'm sending this personally and to the list.  Again I can't keep up with the
list, so if Brett or anyone else has further advice or questions, please
contact me directly.

> > By the way, the last line in that README file says that if this is all
> > too complicated then install the source RPM.  Gee thanks.  I already
> >  tried "rpm --rebuild" but it assumes an i686.
>
> you want rpmbuild

SuSE 8.1 doesn't seem to have it.

> [brett@synapse brett]$ rpmbuild --help
> Usage: rpmbuild [OPTION...]
> <snip>
>   --target=CPU-VENDOR-OS        override target platform

Yeah, that's better than ARCH-VENDOR-OS.  The rpm --rebuild command's
assumed arch of i486 was fine with me, the problem is the assumed cpu of
i686.

Any chance that the rpm --rebuild command's arch-vendor-os might really mean
cpu-vendor-os?  Nah, I guess you would have said so if it were.

> rpmbuild --target=i586 --rebuild modutils-*.src.rpm

Oh, it doesn't need --target=i586-intel-linux  :-?  (By the way, the reason
I come up with snarky questions like this one is that I RTFM.  Sigh.)

