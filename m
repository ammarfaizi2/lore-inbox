Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUF0Jfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUF0Jfr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 05:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUF0Jfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 05:35:47 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:63761 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261451AbUF0Jfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 05:35:46 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: Dan Kegel <dank@kegel.com>
Subject: Re: 2.4.20 rh9 thrashing unreasonably
Date: Sun, 27 Jun 2004 11:34:42 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40DE3E95.4070702@kegel.com>
In-Reply-To: <40DE3E95.4070702@kegel.com>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Linux-Systeme GmbH
Message-Id: <200406271134.42853@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 June 2004 05:27, Dan Kegel wrote:

Hi Dan,

> I have a zippy little 2GHz Athlon XP with 512 MB RAM running
> 2.4.20 (as supplied by Red Hat 9) which
> normally builds gcc/glibc toolchains very quickly.   However,
> when I wrote a script to build 200 different combinations of gcc / glibc /
> target one after the other, deleting each one immediately after installing
> it, performance mysteriously drops after about the 40th iteration;
> the CPU is mostly idle, and the system is swapping like crazy.
> It's turning a several day job into a several week job :-(
> I see someone else reported a similar problem
> (http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=118397), and said
> adjusting a proc setting helped, but they didn't say which one :-(

echo 30 >/proc/sys/vm/inactive_clean_percent
echo 1 10 10 >/proc/sys/vm/pagecache

> Any suggestions on tuning the existing kernel before I pitch it?

use a non-RH kernel.

ciao, Marc
