Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTJSIIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTJSIIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:08:04 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:46246 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262056AbTJSIIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:08:02 -0400
Message-ID: <3F924660.4040405@namesys.com>
Date: Sun, 19 Oct 2003 12:08:00 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Norman Diamond <ndiamond@wta.att.ne.jp>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
       Justin Cormack <justin@street-vision.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vitaly Fertman <vitaly@namesys.com>, Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60> <20031019041553.GA25372@work.bitmover.com>
In-Reply-To: <20031019041553.GA25372@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>
>
>I've told you guys over and over that you need to CRC the data in user
>space, we do that in our backup scripts and it tells us when the drives
>are going bad.  S
>
Why do the CRC in user space, that requires modifying every one of 7000+ applications (if I understand you correctly, which is far from a sure thing;-) )?

Write a reiser4 CRC file plugin.  It would take a weekend, and most of the work would be cut and pasting from the default file plugin..  

I understand why you do it in BK, but for user space as a whole user space is the wrong place.


