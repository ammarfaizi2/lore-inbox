Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbTCGQAW>; Fri, 7 Mar 2003 11:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261648AbTCGQAV>; Fri, 7 Mar 2003 11:00:21 -0500
Received: from havoc.daloft.com ([64.213.145.173]:62401 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261634AbTCGQAU>;
	Fri, 7 Mar 2003 11:00:20 -0500
Date: Fri, 7 Mar 2003 11:10:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Arun Prasad <arun@netlab.hcltech.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 CRC32 undefined
Message-ID: <20030307161050.GA26156@gtf.org>
References: <Pine.LNX.4.44.0303070749160.2876-100000@home.transmeta.com> <1047052741.32200.82.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047052741.32200.82.camel@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:59:01PM +0000, David Woodhouse wrote:
> However, setting the config option to 'Y' when you have only _modular_
> stuff which requires it is broken because it doesn't actually get pulled
> in from lib/lib.a, because nothing references it.

Agreed.  And the fix is to allow 'Y' as expected :)

	Jeff



