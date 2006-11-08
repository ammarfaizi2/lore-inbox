Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbWKHUzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbWKHUzm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbWKHUzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:55:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37092 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932676AbWKHUzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:55:41 -0500
Subject: Re: [PATCH] sysctl: Undeprecate sys_sysctl
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jakub Jelinek <jakub@redhat.com>, Mike Galbraith <efault@gmx.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Bill Nottingham <notting@redhat.com>,
       Marco Roeland <marco.roeland@xs4all.nl>,
       Michael Kerrisk <mtk-manpages@gmx.net>
In-Reply-To: <20061108204948.GC20284@devserv.devel.redhat.com>
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
	 <20061108204948.GC20284@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 21:55:26 +0100
Message-Id: <1163019326.3138.391.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 15:49 -0500, Alan Cox wrote:
> On Wed, Nov 08, 2006 at 12:00:10PM -0700, Eric W. Biederman wrote:
> > Now that I know there are a few real users the only sane way to
> > proceed with deprecation is to push the time limit out to a year or
> > two work and work with distributions that have big testing pools like
> > fedora core to find these last remaining users.
> 
> Some early boot code needs to know the kernel version and
> it needs to do it before /proc is mounted and potentially in order
> to run mount. In places it has its role but only in places.

isn't kernel version passed as AT vector nowadays?


