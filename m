Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263368AbTJFRp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263222AbTJFRo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:44:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:32157 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263828AbTJFRoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:44:38 -0400
Date: Mon, 6 Oct 2003 10:36:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/parser: Not recognize nul string as "%s" (6/6)
Message-Id: <20031006103602.4cf8f5d7.rddunlap@osdl.org>
In-Reply-To: <87wubinvzs.fsf@devron.myhome.or.jp>
References: <87wubinvzs.fsf@devron.myhome.or.jp>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Oct 2003 01:58:47 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

| Hi,
| 
| Current match_token recognize "foo=" as "foo=%s". So this change the
| nul string does not recognize as "%s".
| 
| (Umm... this should be check by caller?)

I like the check here.

And thanks for doing all of these updates.


|  linux-2.6.0-test6-hirofumi/lib/parser.c |    4 +++-
|  1 files changed, 3 insertions(+), 1 deletion(-)


--
~Randy
