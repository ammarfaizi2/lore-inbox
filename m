Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318084AbSHHXG4>; Thu, 8 Aug 2002 19:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318085AbSHHXG4>; Thu, 8 Aug 2002 19:06:56 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:33551 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318084AbSHHXGz>;
	Thu, 8 Aug 2002 19:06:55 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208082309.g78N9Xs38843@saturn.cs.uml.edu>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 8 Aug 2002 19:09:33 -0400 (EDT)
Cc: frankeh@us.ibm.com (Hubertus Franke), riel@conectiva.com.br (Rik van Riel),
       aebr@win.tue.nl (Andries Brouwer), akpm@zip.com.au (Andrew Morton),
       andrea@suse.de, davej@suse.de, linux-kernel@vger.kernel.org (lkml),
       plars@austin.ibm.com (Paul Larson)
In-Reply-To: <Pine.LNX.4.44.0208081519010.1661236-100000@home.transmeta.com> from "Linus Torvalds" at Aug 08, 2002 03:26:00 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> "ps" seems to do ok from a visual standpoint at least up to 99 million. 
> Maybe it won't look that good after that, I'm too lazy to test.

Mind sharing what "ps -fj", "ps -lf", and "ps j" look like?
The standard tty is 80x24 BTW, and we already have serious
problems due to ever-expanding tty names.

How about a default limit of 9999, to be adjusted by
sysctl as needed?

