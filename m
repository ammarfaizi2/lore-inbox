Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317674AbSGUOSD>; Sun, 21 Jul 2002 10:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSGUOSB>; Sun, 21 Jul 2002 10:18:01 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:54659 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S317674AbSGUORj>;
	Sun, 21 Jul 2002 10:17:39 -0400
Subject: Re: memory leak?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andrew Rodland <arodland@noln.com>
Cc: M <mru@users.sourceforge.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020722100840.2599c2f3.arodland@noln.com>
References: <yw1xn0sluqom.fsf@gladiusit.e.kth.se> 
	<20020722100840.2599c2f3.arodland@noln.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 21 Jul 2002 16:20:39 +0200
Message-Id: <1027261239.785.8.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

free don't know about slabcaches. take a look in /proc/slabinfo and see
what's using that memory. it's not a leak, the memory will be free'd
when the machine is under enough memory pressure.

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.
