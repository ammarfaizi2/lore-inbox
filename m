Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVCHS4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVCHS4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVCHS4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:56:37 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29908 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261515AbVCHSz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:55:58 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       paul@linuxaudiosystems.com, mpm@selenic.com, joq@io.com,
       cfriesen@nortelnetworks.com, Chris Wright <chrisw@osdl.org>,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050308043250.GA32746@infradead.org>
References: <20050112185258.GG2940@waste.org>
	 <200501122116.j0CLGK3K022477@localhost.localdomain>
	 <20050307195020.510a1ceb.akpm@osdl.org>
	 <20050308035503.GA31704@infradead.org>
	 <20050307201646.512a2471.akpm@osdl.org> <20050308042242.GA15356@elte.hu>
	 <20050307202821.150bd023.akpm@osdl.org>
	 <20050308043250.GA32746@infradead.org>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 13:55:55 -0500
Message-Id: <1110308156.4401.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 04:32 +0000, Christoph Hellwig wrote:
> and as I mentioned a few times if we really want to go for a magic
> uid/gid-based approach we should at least have one that's useable for
> all capabilities so it can replace the oracle hack aswell.  But the
> proponents of the patch weren't iterested to invest the tiniest bit
> of work over what they submited.

And as I mentioned a few times, the authors have neither the inclination
nor the ability to do that, because they are not kernel hackers.  The
realtime LSM was written by users (not developers) of the kernel, to
solve a specific real world problem.  No one ever claimed it was the
correct solution from the kernel POV.

I know Jack disagrees but I for one am glad to see the max-RT-prio
rlimit patch going in.  This probably reflects my sysadmin background,
PAM does not scare me at all.  Anyway it solves the same problem and
will be invisible to any user with a reasonable distro.  If musicians
end up having to tweak the PAM configuration, then I would say the
distro has failed miserably.

Lee

