Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267253AbUHDF2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267253AbUHDF2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267252AbUHDF2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:28:21 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:30432 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267259AbUHDF1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:27:30 -0400
Date: Wed, 4 Aug 2004 01:31:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MTRR driver model support broken on SMP.
In-Reply-To: <1091596967.3189.86.camel@laptop.cunninghams>
Message-ID: <Pine.LNX.4.58.0408040128490.19619@montezuma.fsmlabs.com>
References: <1091585241.3303.6.camel@laptop.cunninghams> 
 <Pine.LNX.4.58.0408040119270.19619@montezuma.fsmlabs.com>
 <1091596967.3189.86.camel@laptop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Nigel Cunningham wrote:

> > Looking at this i'm really curious as to whether we need to bother at all,
> > can you remove the mtrr restore code and then compare /proc/mtrr before
> > and after suspending.
>
> I haven't had problems but do remember 2.4 users who had trouble with X
> before code to save and restore mtrrs was added.

Ahh yes, X11 will create an additional entry on startup whilst the
boot MTRR settings don't have it.
