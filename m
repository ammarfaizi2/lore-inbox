Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262961AbSJBES1>; Wed, 2 Oct 2002 00:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262962AbSJBES1>; Wed, 2 Oct 2002 00:18:27 -0400
Received: from packet.digeo.com ([12.110.80.53]:49399 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262961AbSJBES0>;
	Wed, 2 Oct 2002 00:18:26 -0400
Message-ID: <3D9A74CF.8C8585E7@digeo.com>
Date: Tue, 01 Oct 2002 21:23:43 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: input layer strangeness
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2002 04:23:44.0180 (UTC) FILETIME=[7E863F40:01C269CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's been doing this ever since the input layer changes:

- open a few xterms
- press the spacebar, leave pressed
- start waggling the mouse about
- stop pressing spacebar, keep waggling the mouse about,
  across the xterms

The keystrokes *never* stop coming.  Just the continuous mouse
activity causes a stream of keyboard input, at seemingly the normal
autorepeat rate. I can keep them coming for 30 seconds, just by
moving the mouse.

In practice, it's irritating because it's quite easy to get a
stream of erroneous input dumped into the wrong windows.

It's a vanilla dual pentium with an AT keyboard and a PS/2
mouse.
