Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272893AbTG3OXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272920AbTG3OXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:23:36 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:56079 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S272893AbTG3OVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:21:13 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Herbert =?iso-8859-1?q?P=F6tzl?= <herbert@13thfloor.at>
Subject: Re: ROOT NFS fixes ...
Date: Wed, 30 Jul 2003 16:20:26 +0200
User-Agent: KMail/1.5.2
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
References: <20030729211521.GA19594@www.13thfloor.at> <Pine.LNX.4.55L.0307301057030.29278@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0307301057030.29278@freak.distro.conectiva>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307301620.11886.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 July 2003 15:57, Marcelo Tosatti wrote:

Hi Marcelo, Herbert,

> > just verified that the NFS root bug-fix was not
> > included in 2.4.22-pre9, unfortunately I have
> > to ask you again, why you do not want to fix
> > this issue in 2.4.22 ...
> > I do not understand why Trond obviously is
> > ignoring my mails, regarding this particular
> > issue, maybe he is just too busy to look at
> > four twoline changes, and more, I do not
> > understand why this isn't accepted into the
> > marcelo kernel tree, as it obviously fixes a
> > misbehaviour?

> I do not consider the patch critical enough.
> Get it in 2.5 first, then come back :)
err, correct me if I am totally wrong here but does "ROOT NFS fixes" means 
somewhat like

append="nfsroot=10.0.0.7:/home/nfsroot \
    ip=10.0.0.254:10.0.0.7:10.0.0.7:255.255.255.0:temp:eth0:off root=/dev/nfs"

does not work w/o the fix?

ciao, Marc

