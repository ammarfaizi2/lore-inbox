Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317801AbSGVVBG>; Mon, 22 Jul 2002 17:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317805AbSGVVBG>; Mon, 22 Jul 2002 17:01:06 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:29960 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317801AbSGVVBG>; Mon, 22 Jul 2002 17:01:06 -0400
Date: Mon, 22 Jul 2002 22:04:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.27: s390 fixes.
Message-ID: <20020722220413.A12952@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org
References: <mailman.1027363500.9793.linux-kernel2news@redhat.com> <200207222100.g6ML0UN08293@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207222100.g6ML0UN08293@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, Jul 22, 2002 at 05:00:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 05:00:30PM -0400, Pete Zaitcev wrote:
> > * add sys_security system call
> 
> I do not see the body of the call in the attached patch.

Does need to.  Is yet another magic dispatcher that has randomly changing
behaviour depending on the linux crap^H^H^H^Hsecurity module loaded.

