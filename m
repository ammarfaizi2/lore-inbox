Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271204AbTGWSL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271202AbTGWSL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:11:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31892 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271197AbTGWSKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:10:23 -0400
Date: Wed, 23 Jul 2003 11:23:07 -0700
From: "David S. Miller" <davem@redhat.com>
To: Glenn Fowler <gsf@research.att.com>
Cc: gsf@research.att.com, dgk@research.att.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: kernel bug in socketpair()
Message-Id: <20030723112307.5b8ae55c.davem@redhat.com>
In-Reply-To: <200307231814.OAA74344@raptor.research.att.com>
References: <200307231428.KAA15254@raptor.research.att.com>
	<20030723074615.25eea776.davem@redhat.com>
	<200307231656.MAA69129@raptor.research.att.com>
	<20030723100043.18d5b025.davem@redhat.com>
	<200307231724.NAA90957@raptor.research.att.com>
	<20030723103135.3eac4cd2.davem@redhat.com>
	<200307231814.OAA74344@raptor.research.att.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 14:14:57 -0400 (EDT)
Glenn Fowler <gsf@research.att.com> wrote:

> named sockets seem a little heavyweight for this application

I think it'll be cheaper than unnamed unix sockets and
groveling in /proc/*/fd/

And even if there is a minor performance issue, you'll more than get
that back due to the portability gain. :-)
