Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbTH0QX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbTH0QXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:23:51 -0400
Received: from mail.hometree.net ([212.34.181.120]:7067 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S263618AbTH0QXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:23:10 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: osirusoft.com DNS BLs are broken ...
Date: Wed, 27 Aug 2003 16:23:08 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <biiltc$h01$1@tangens.hometree.net>
References: <20030826160252.GF16395@mea-ext.zmailer.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1062001388 17409 212.34.181.4 (27 Aug 2003 16:23:08 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 27 Aug 2003 16:23:08 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio <matti.aarnio@zmailer.org> writes:

>That in itself should not be any difficulty, but MANY
>filter codes in different MTAs appear to treat that as
>if there is genuine registered rejection!

>I have seen this at sendmails (up to and including lattest),
>and at Postfix!   But also at several systems not willing
>to tell what they are running do exhibit this very same
>misbehaviour.

sendmail:

--- cut --
dnsbl           Turns on rejection of hosts found in an DNS based rejection
                list.  If an argument is provided it is used as the domain
[...]
                information.  By default, temporary lookup failures are
                ignored.  This behavior can be changed by specifying a
                third argument, which must be either `t' or a full error
                message.  See the anti-spam configuration control section for
--- cut --

_Anyone_ changing the default behaviour of "temporary lookup failure"
to reject mail should be treated with a really large clue-bat (TM). 

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)
