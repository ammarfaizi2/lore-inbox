Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbTDYRLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 13:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTDYRLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 13:11:46 -0400
Received: from [62.37.236.142] ([62.37.236.142]:52220 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S263165AbTDYRLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 13:11:43 -0400
Message-ID: <3EA96F27.3090207@wanadoo.es>
Date: Fri, 25 Apr 2003 19:23:51 +0200
From: =?ISO-8859-1?Q?xos=E9_v=E1zquez_p=E9rez?= <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [proposition of drivers documentation]
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi guys,

to try to avoid lost bug fixed and situations like this thread:
http://marc.theaimsgroup.com/?t=104327599900004&r=1&w=2
and to get more information about drivers/hardware duet.

I propose to include in every main driver file( but it can
be extensive to other files):

notes:
- [] _mandatory_
- dates and times are in _UTC_

fields are trivial but some need an explication:

- [modification #]: necessary because not all people change
  the driver version every time it's made a modification.
  It's _mandatory_ change it when you touch the file.
  And always it's relative to _official kernel_ version
  that you have modified plus 1.
- [quality]: there are very basic drivers, they works but
  they don't have manufacturer support or documentation.
  They are good to play but not for high servers
  because they lack of higher features or performance.

/*
=HEADER

 [name]: foo bar adapters family
 [author]: Name <e-mail@server.com> or/and <mailing-list@server.com>
 [date]: 00:00:00 11/12/1969
 [license]: BSD/GPL/dual GPL-BSD

 [maintainer]: Name <e-mail@server.com> or/and <mailing-list@server.com>
 [bugs]: <mailing-list@server.com> or/and Name <e-mail@server.com>
 [kernel_version]: >2.5.49 2.4.21
 [state]: stable/devel/unstable or 1/2/3
 [quality]: high/medium/low or 1/2/3
 [version]: 00.00.00
 [date]: 00:00:00 01/01/2001
 [modification #]: AAA00001
 url_info: http://www.server.com/hacker/my-driver-info/
 url_down: ftp://ftp.server.com/pub/drivers/linux/
 mailing-list: if clouse url or <e-mail> to subscribe or real <e-mail>
 cvs:

=END
*/

/*
=CHANGELOG

 [Changelog]: (latest at top)

 [date] [version] or [modification #] [<e-mail@server.com>]
 - bug fixes at makemelove()
 ...

=END
*/

/*
=HARDWARE

 [Supported hardware]:

 [manufacturer_1]
        [product name]

 [manufacturer_2]
        [product name]

=END
*/

/*
=NOTES

 notes:

 Hardware was designed by acme labs and it works like a sex machine.
 You need update firmware to XXX version because it
 has a lots of fuck*d hardware problems and ...

=END
*/

and in the other driver files (*.c or *.h )

/*

 [license]: BSD/GPL/dual GPL-BSD
 [modification #]: AAA00080
 [depends]: midriver.c

*/

It would be possible to put tags or something to make marks and
to extract documentation about drivers and supported hardware like
perl auto-documented files.
It will make easier the linux vendors work.

Another idea is to put under Documentacion/ the same tree than
the kernel files, to move all README.* CHANGELOG.* inside this tree.
And to change the name to a more standard like driver-name.readme and
driver-name.changelog

There are too much chaos and sometimes it is very hard to find
real information and updated. Because LiNUX hasn't a perpetual kernel
team and people go and come ;-)

IMHO.

-thank you for to read this-

regards,
-- 
Software is like sex, it's better when it's bug free.

