Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317528AbSGOQ1W>; Mon, 15 Jul 2002 12:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317531AbSGOQ1V>; Mon, 15 Jul 2002 12:27:21 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:12798 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317528AbSGOQ1U>; Mon, 15 Jul 2002 12:27:20 -0400
Date: Mon, 15 Jul 2002 12:30:11 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Lincoln Dale <ltd@cisco.com>
Cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, Steve Lord <lord@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 performance in 2.5.25 versus 2.4.19pre8aa2
Message-ID: <20020715123011.B2487@redhat.com>
References: <3D2CFA75.FBFD6D92@zip.com.au> <5.1.0.14.2.20020711132113.021a6de0@mira-sjcm-3.cisco.com> <3D2CFF48.9EFF9C59@zip.com.au> <5.1.0.14.2.20020714202539.022c4270@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20020714202539.022c4270@mira-sjcm-3.cisco.com>; from ltd@cisco.com on Sun, Jul 14, 2002 at 10:22:56PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 10:22:56PM +1000, Lincoln Dale wrote:
> one-line summary is that some results are better, some are worse; CPU usage 
> is better in 2.5.25, but thoughput is sometimes
> worse.

You might want to rerun your tests on 2.5.25 after redefining HZ to be 100, 
or setting HZ to 1000 in the 2.4 kernel.

		-ben
