Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267945AbTAHWel>; Wed, 8 Jan 2003 17:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267946AbTAHWek>; Wed, 8 Jan 2003 17:34:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13289 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267945AbTAHWej>;
	Wed, 8 Jan 2003 17:34:39 -0500
Date: Wed, 08 Jan 2003 14:34:41 -0800 (PST)
Message-Id: <20030108.143441.31155028.davem@redhat.com>
To: torvalds@transmeta.com
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0301081222430.5369-100000@home.transmeta.com>
References: <20030108195934.GA35912@compsoc.man.ac.uk>
	<Pine.LNX.4.44.0301081222430.5369-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 8 Jan 2003 12:28:23 -0800 (PST)

   Don't add stupid bloat to the kernel because somebody is silly
   enough to care about a 32-bit oprofile working with a 64-bit kernel. 
   
Being that 32-bit is the primary (and in many ways, ONLY) userland for
at least 2 64-bit kernel platforms, I think this does matter.

We're exporting an int to userland, what kind of bloat is that really?
