Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSHGLsj>; Wed, 7 Aug 2002 07:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSHGLsj>; Wed, 7 Aug 2002 07:48:39 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6553 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317189AbSHGLsf>; Wed, 7 Aug 2002 07:48:35 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208071151.g77Bpmt19650@devserv.devel.redhat.com>
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
To: ak@suse.de (Andi Kleen)
Date: Wed, 7 Aug 2002 07:51:48 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), ak@suse.de (Andi Kleen),
       alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020807131813.A25485@wotan.suse.de> from "Andi Kleen" at Aug 07, 2002 01:18:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thats a packaging issue for distributed prebuilt kernel trees. Also crashes
> > are the only way you are going to find out what needs fixing, who wants to
> > fix it and the like
> 
> I disagree. In my opinion such low standards on the kernel configuration
> are not acceptable.  Things that 100% will not work should not be
> visible.

Time to chmod 0 the v2.5 directory.

In a perfect would I'd be able to have config_experimental let me pick all
the stuff not tested on x86_64. To do that sanely we have to fix the
configuration language otherwise it will just never be maintainable and
we will spend the rest of 2.4 haunted by "Why has xyz vanished on Alpha 
in 2.4.21"
