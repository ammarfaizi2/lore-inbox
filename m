Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTE3R0y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTE3R0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:26:54 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:54241 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263824AbTE3R0v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:26:51 -0400
Date: Fri, 30 May 2003 19:10:09 +0200 (CEST)
From: eduard.epi@t-online.de (Peter Bornemann)
To: linux-kernel@vger.kernel.org
Subject: Login funny in 2.5.70
Message-ID: <Pine.LNX.4.44.0305301841360.1387-100000@eduard.epiphanien>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Seen: false
X-ID: r2Muu0Z6oeME6-PY1vfLXX5gvLLoeI9Mltc6W2fFD+IAvFYWlU0cot@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

When logging as normal user to my system, I get all the usual messages
and then when /etc/profile tries to read /proc/$$/exe to determine the
running shell I get (most of the time):

/bin/ls: cannot read symbolic link /proc/###/exe: Permission denied

When I start "bash -l", everything works as expected, but no idea why
it does work this time and not when starting from the login: prompt.
Permissions of the link /proc/$$/exe are always 777, so I cannot see
any problem.

All this does not appear all the time and never to root. It seems to be a
matter of timing or something like that, but I do not have any idea as to
what is happening in kernel. 2.5.69 is working, 2.5.70 is funny. When
the first read did fail, it will fail always afterwards and vice versa.

This is on Debian testing, bash version is 2.05b.0, gcc is 3.3
(Debian), arch is i386/Athlon 700.

Every help will be greatly appreciated.

Peter B


          .         .
          |\_-^^^-_/|
          / (|)_(|) \
         ( === X === )
          \  ._|_.  /
           ^-_   _-^
              °°°

