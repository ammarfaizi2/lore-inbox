Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbRGPX01>; Mon, 16 Jul 2001 19:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267733AbRGPX0R>; Mon, 16 Jul 2001 19:26:17 -0400
Received: from patan.Sun.COM ([192.18.98.43]:23727 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S267732AbRGPX0J>;
	Mon, 16 Jul 2001 19:26:09 -0400
Message-ID: <3B5379A9.6A9B11BE@sun.com>
Date: Mon, 16 Jul 2001 16:32:57 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NGROUP increase - thoughts
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure this has been given thought, so I want to probe teh collective
resources.  We need to have users in more than 32 groups.  In fact, they
may need to be a member of MANY more groups than that.

What is the current thinking on this problem?  Would it be desirable to
replace current->groups[NGROUPS] with a poibnter to an array?  Thus
allowing (with libc changes) many more groups?

Comments, please.
Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
