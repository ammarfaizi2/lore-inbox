Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSIIPge>; Mon, 9 Sep 2002 11:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSIIPge>; Mon, 9 Sep 2002 11:36:34 -0400
Received: from [63.209.4.196] ([63.209.4.196]:40964 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317400AbSIIPgd>; Mon, 9 Sep 2002 11:36:33 -0400
Date: Mon, 9 Sep 2002 08:40:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hans Reiser <reiser@namesys.com>
cc: green@namesys.com, <linux-kernel@vger.kernel.org>
Subject: Re: [BK] PATCH ReiserFS 1 of 3 RESEND
In-Reply-To: <20020909113147.BBA73A7CDF@reload.namesys.com>
Message-ID: <Pine.LNX.4.44.0209090831240.1641-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hans,
 one of the reasons for problems with your patches is that your emails 
seem to sometimes be labeled as spam.

And one of the major reasons for that is apparently simply that your 
"From:" address is not a good one:

	From: reiser@reload.namesys.com (Hans Reiser)

where "reload.namesys.com" is not in the MX domain:

	dig -t MX reload.namesys.com

gives no answer. As a result, spam detectors look at the From: line and 
consider you an extremely suspect person, likely to be up to no good.

I would suggest you fix your mailer to have a valid MX-record return 
address, ie <reiser@namesys.com> instead of <reiser@reload.namesys.com>.

(Yes, I realize that both addresses likely work perfectly fine, and that
"reload"  is the machine you actually use for sending the email, but
still.. I bet I'm not the only one who uses spam filtering software that
cares about issues like this.)

[ Cc to linux-kernel left intact not to publicly castigate Hans, but 
  because I know this is true for some other people too. ]

			Linus

