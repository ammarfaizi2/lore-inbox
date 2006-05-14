Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWENEiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWENEiO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 00:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWENEiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 00:38:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62181 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750921AbWENEiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 00:38:14 -0400
Date: Sun, 14 May 2006 00:37:55 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, jak@isp2dial.com,
       linux-kernel@vger.kernel.org
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
Message-ID: <20060514043755.GA2984@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	jak@isp2dial.com, linux-kernel@vger.kernel.org
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net> <20060511175143.GH25646@redhat.com> <Pine.LNX.4.61.0605121243460.9918@yvahk01.tjqt.qr> <200605121619.k4CGJCtR004972@isp2dial.com> <Pine.LNX.4.58.0605121222070.5579@gandalf.stny.rr.com> <200605121630.k4CGUuiU005025@isp2dial.com> <Pine.LNX.4.64.0605120949060.3866@g5.osdl.org> <20060513201144.4891ef17.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513201144.4891ef17.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 08:11:44PM -0700, Andrew Morton wrote:

 > So at this stage, 2.6.18 still appears to be a good time to start pushing
 > people toward cifs, and December looks like an appropriate time to mark
 > smbfs as broken.  Subject to, of course, feedback-from-the-field.

I'm surprised that other vendors are actually still shipping it[1].
(Not only that, some vendors have actually been sitting on smbfs
 patches for well over a year).

Given that it's clearly abandoned, moving to cifs seems to be the
only sensible thing to do, and anything that can be done to ease
that transition should be done.

		Dave

[1] Especially after the recent security problem where smbfs stayed
vulnerable for a week or so after CIFS got fixed.  How many bad guys
thought "Hmm, wonder if smbfs has the same bug" in that week?

-- 
http://www.codemonkey.org.uk
