Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVEQUgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVEQUgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVEQUgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:36:40 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49079 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261941AbVEQUgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:36:32 -0400
Subject: Re: software mixing in alsa
From: Lee Revell <rlrevell@joe-job.com>
To: Valdis.Kletnieks@vt.edu
Cc: Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu>
References: <20050517095613.GA9947@kestrel>
	 <200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel>
	 <1116354762.31830.12.camel@mindpipe>
	 <20050517192412.GA19431@kestrel.twibright.com>
	 <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 17 May 2005 16:36:30 -0400
Message-Id: <1116362191.32210.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 16:27 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 17 May 2005 21:24:12 +0200, Karel Kulhavy said:
> > Lee Revell wrote:
> > 
> > > Finally, these questions are all OT for LKML.  Try alsa-user at
> > > lists.sf.net and alsa-devel at lists.sf.net.  Also there's a bug
> > 
> > ALSA is a part of Linux kernel, right? This is linux-kernel. Why
> > is it OT here? Doesn't make sense for me.
> 
> I was hoping somebody would explain how to get 'dmix' plugin working in the
> kernel - then I could get rid of esd ;)  (Note that running something in
> userspace that accepts connections, runs dmix on them, and then creates one
> thing spewing to /dev/pcm isn't a solution - I've already *got* esd, warts and all)

I don't understand your message very well.  The dmix plugin is part of
alsa-lib, which is part of userspace.  From the application's point of
view, it does not matter whether the mixing happens in kernel or not.
ALSA follows the philosophy of doing as little as possible in the
kernel, and since mixing and volume control work fine in userspace,
that's where they live.

Lee 

