Return-Path: <linux-kernel-owner+w=401wt.eu-S932757AbWLNUGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbWLNUGs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbWLNUGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:06:48 -0500
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:56739
	"EHLO vs166246.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761AbWLNUGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:06:47 -0500
X-Greylist: delayed 2189 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 15:06:47 EST
From: Michael Buesch <mb@bu3sch.de>
To: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Thu, 14 Dec 2006 20:29:47 +0100
User-Agent: KMail/1.9.5
References: <20061214003246.GA12162@suse.de> <4580E37F.8000305@mbligh.org> <1166105545.6748.212.camel@gullible>
In-Reply-To: <1166105545.6748.212.camel@gullible>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612142029.47753.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 December 2006 15:12, Ben Collins wrote:
> You can't talk about drivers that don't exist for Linux. Things like
> bcm43xx aren't effected by this new restriction for GPL-only drivers.
> There's no binary-only driver for it (ndiswrapper doesn't count). If the
> hardware vendor doesn't want to write a driver for linux, you can't make
> them. You can buy other hardware, but that's about it.

Not that is matters in this discussion, but there are binary Broadcom
43xx drivers for linux available.

> Here's the list of proprietary drivers that are in Ubuntu's restricted
> modules package:
> 
> 	madwifi (closed hal implementation, being replaced in openhal)
> 	fritz

Well, that's not just one, right?
That's like, 10 or so for the different AVM cards.
I'm just estimating. Correct me, if I'm wrong.

(And if I didn't mention it yet; AVM binary drivers are
complete crap.)

> 	ati
> 	nvidia
> 	ltmodem (does that even still work?)
> 	ipw3945d (not a kernel module, but just the daemon)

> Don't get me wrong, I'm not bashing reverse engineering, or writing our
> own drivers. It's how Linux got started. But the problem isn't as narrow
> as people would like to think. And proprietary code isn't a growing
> problem. At best, it's just a distraction that will eventually go away
> on it's own.

Well, I _hope_ that, too.

-- 
Greetings Michael.
