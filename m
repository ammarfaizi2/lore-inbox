Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVBYXYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVBYXYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVBYXYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:24:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:65223 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262801AbVBYXYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:24:48 -0500
Subject: Re: Xterm Hangs - Possible scheduler defect?
From: Lee Revell <rlrevell@joe-job.com>
To: "Chad N. Tindel" <chad@tindel.net>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Paulo Marques <pmarques@grupopie.com>,
       Chris Friesen <cfriesen@nortel.com>, Mike Galbraith <EFAULT@gmx.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050225210225.GA89109@calma.pair.com>
References: <20050224075756.GA18639@calma.pair.com>
	 <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com>
	 <421E1AC1.1020901@nortel.com> <20050224183851.GA24359@calma.pair.com>
	 <421E2528.8060305@grupopie.com> <20050224192237.GA31894@calma.pair.com>
	 <20050225202543.GA1249@hh.idb.hist.no>
	 <20050225210225.GA89109@calma.pair.com>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 18:24:46 -0500
Message-Id: <1109373886.14434.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 16:02 -0500, Chad N. Tindel wrote:
> They're expensive and customers don't expect a single userspace thread to
> tie up the other 63 CPUs no matter how buggy it is.  It is intuitively obvious
> that a buggy kernel can bring a system to its knees, but it is not intuitively
> obvious that a buggy userspace app can do the same thing.  It is more of a 
> supportability issue than anything, because you expect the other processors
> to function properly so you can get in and live-debug the application when it
> hits a bug that makes it CPU-bound.  This is especially important if the box 
> is, say, in a remote jungle of China or something where you don't have access 
> to the console.

"Unix policy is to not stop root from doing stupid things because
that would also stop him from doing clever things." - Andi Kleen

"It's such a fine line between stupid and clever" - Derek Smalls

Lee

