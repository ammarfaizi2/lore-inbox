Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSGGJ7S>; Sun, 7 Jul 2002 05:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSGGJ7R>; Sun, 7 Jul 2002 05:59:17 -0400
Received: from news.cistron.nl ([62.216.30.38]:40719 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S314422AbSGGJ7R>;
	Sun, 7 Jul 2002 05:59:17 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Serial: updated serial drivers
Date: Sun, 7 Jul 2002 10:01:48 +0000 (UTC)
Organization: Cistron
Message-ID: <ag93ic$hcb$1@ncc1701.cistron.net>
References: <20020707010009.C5242@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1026036108 17803 62.216.29.67 (7 Jul 2002 10:01:48 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020707010009.C5242@flint.arm.linux.org.uk>,
Russell King  <rmk@arm.linux.org.uk> wrote:
> - remove callout functionality, which has been marked as such for
>   a few years now.  tytso mentions that the only program this
>   might break is minicom, which should be fixed.

Minicom doesn't care which port you use. It might be that some
people have saved configs of 6 years old that still contain
references to a cua device, but that's a problem any serial
program has.

>From the manpage of any recent minicom:

       Serial port setup
          *A - Serial device
               /dev/tty1   or   /dev/ttyS1   for   most   people.
               /dev/cua<n> is still possible under linux, but not
               recommended  any  more  because  these devices are
               obsolete and many  newly  installed  systems  with
               kernel  2.2.x  don't  have them.  Use /dev/ttyS<n>
               instead.

Mike.

