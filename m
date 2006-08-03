Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWHCBgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWHCBgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 21:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWHCBgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 21:36:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751130AbWHCBgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 21:36:19 -0400
Date: Wed, 2 Aug 2006 18:36:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mm snapshot broken-out-2006-08-02-00-27.tar.gz uploaded
Message-Id: <20060802183613.792e2488.akpm@osdl.org>
In-Reply-To: <6bffcb0e0608021700n49a3ed6cnbbe421a22946f54c@mail.gmail.com>
References: <200608020728.k727SegM012704@shell0.pdx.osdl.net>
	<6bffcb0e0608021700n49a3ed6cnbbe421a22946f54c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 02:00:42 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> On 02/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > The mm snapshot broken-out-2006-08-02-00-27.tar.gz has been uploaded to
> >
> >    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-02-00-27.tar.gz
> >
> 
> There is something wrong with this kernel. I have noticed, that after
> 1,5 hour some of the keys on my keyboard doesn't work... amarok
> doesn't want to play music (30 sec gaps between songs etc.), switching
> between firefox/openoffice takes 1 min. I don't see nothing special in
> the logs. It is a CPU scheduler problem?
> 

Could be a timekeeping problem, perhaps.  Is it SMP?  Is the time-of-day
increasing at the right speed?  Does `sleep 5' do the right thing?
