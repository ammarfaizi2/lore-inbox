Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131352AbRCWTPv>; Fri, 23 Mar 2001 14:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131351AbRCWTPp>; Fri, 23 Mar 2001 14:15:45 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:48395 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S131349AbRCWTPe>;
	Fri, 23 Mar 2001 14:15:34 -0500
Date: Fri, 23 Mar 2001 14:14:49 -0500
From: Zach Brown <zab@zabbo.net>
To: Fabio Riccardi <fabio@chromium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: user space web server accelerator support
Message-ID: <20010323141449.B24144@tetsuo.zabbo.net>
In-Reply-To: <3AB6D0A5.EC4807E3@chromium.com> <15030.54194.780246.320476@pizda.ninka.net> <3AB6D574.8C123AE9@chromium.com> <15030.54685.535763.403057@pizda.ninka.net> <3ABAC8D4.B464EB9B@chromium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3ABAC8D4.B464EB9B@chromium.com>; from fabio@chromium.com on Thu, Mar 22, 2001 at 07:53:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Zach, have you ever noticed such a performance bottleneck in your phhttpd?

yup, this is definitely something you don't want to be doing in the fast
path :)

> Any thoughts?

Sorry I don't remember the start of this thread, but I'll ask anyway;
have you looked at Ingo Molnar's Tux server?  Its state of the art unix
serving, implemented in the linux kernel:

http://people.redhat.com/mingo/TUX-patches/

-- 
 zach
