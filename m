Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUEELaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUEELaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 07:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbUEELap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 07:30:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:16271 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263761AbUEELao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 07:30:44 -0400
Date: Wed, 5 May 2004 04:30:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-Id: <20040505043002.2f787285.akpm@osdl.org>
In-Reply-To: <200405051312.30626.dominik.karall@gmx.net>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<200405051312.30626.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall <dominik.karall@gmx.net> wrote:
>
> On Wednesday 05 May 2004 10:31, you wrote:
> > +make-4k-stacks-permanent.patch
> >
> >  Fill my inbox.
> 
> Hi Andrew!
> 
> Is there any reason why this patch was applied? Because NVidia users can't 
> work with the original drivers now without removing this patch every time.
> 

We need to push this issue along quickly.  The single-page stack generally
gives us a better kernel and having the stack size configurable creates
pain.
