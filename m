Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTD1OLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 10:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbTD1OLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 10:11:07 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1704 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261153AbTD1OLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 10:11:06 -0400
Subject: Re: [PATCH] 2.5.68 fs/ext3/super.c fix for orphan recovery error
	path
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Ernie Petrides <petrides@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030421150809.22d21362.akpm@digeo.com>
References: <200304212014.h3LKE4bP002830@pasta.boston.redhat.com>
	 <20030421150809.22d21362.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051539800.2021.35.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Apr 2003 15:23:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2003-04-21 at 23:08, Andrew Morton wrote:
> Ernie Petrides <petrides@redhat.com> wrote:
> >
> > Stephen/Andrew, please consider applying this patch to reverse the order
> > of checks in ext3_orphan_cleanup() for read-only mounts and prior errors.
> > 
> 
> Thanks, that is definitely needed.  We should do this in 2.4 as well.

Yes, I'll push it to marcelo.

--Stephen

