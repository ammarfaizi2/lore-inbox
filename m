Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267719AbTAIADu>; Wed, 8 Jan 2003 19:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267722AbTAIADt>; Wed, 8 Jan 2003 19:03:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58857 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267719AbTAIADt>;
	Wed, 8 Jan 2003 19:03:49 -0500
Date: Wed, 08 Jan 2003 16:03:52 -0800 (PST)
Message-Id: <20030108.160352.78071329.davem@redhat.com>
To: torvalds@transmeta.com
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0301081601300.1096-100000@penguin.transmeta.com>
References: <20030108.150303.130044451.davem@redhat.com>
	<Pine.LNX.4.44.0301081601300.1096-100000@penguin.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 8 Jan 2003 16:02:24 -0800 (PST)
   
   Or you can use an /etc/systype file that contains information.
   
That sounds fine to me.

A funny way to initialize this could be by reading System.map
and seeing how many significant hexidecimal digits are used
to list the kernel symbol addresses :-)
