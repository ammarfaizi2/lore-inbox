Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268415AbTGISIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 14:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268438AbTGISIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 14:08:55 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:25350 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S268415AbTGISIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 14:08:52 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ->direct_IO API change in current 2.4 BK
Date: Wed, 9 Jul 2003 20:22:35 +0200
User-Agent: KMail/1.5.2
Cc: Andreas Dilger <adilger@clusterfs.com>, Andrea Arcangeli <andrea@suse.de>,
       Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
References: <20030709133109.A23587@infradead.org> <200307091954.12895.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307092022.35295.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 July 2003 20:08, Marcelo Tosatti wrote:

Hi Marcelo,

> Ok, right. Well, I dont know why it doesnt happen there. Maybe not enough
> testing?
aehm, I'll bet -aa is tested _alot_ and also -wolk has tons of testers, but 
well, this is a different talk ;)

> Anyway, I'm going to revert the NFS DIRECT IO patch because, as Christoph
> mentioned, breaks the API.
> I except another solution from Trond (maybe ->direct_IO2).
I wonder why you merge such stuff then in the first place, if you agree with 
hch's opinion, that an API should not change in stable kernel series in the 
2nd place? ... Did you temporarly forget it? ;)

ciao, Marc

