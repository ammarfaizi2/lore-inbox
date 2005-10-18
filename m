Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVJRIrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVJRIrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 04:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVJRIrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 04:47:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:49362 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932426AbVJRIrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 04:47:20 -0400
Date: Tue, 18 Oct 2005 10:47:06 +0200
From: Olaf Hering <olh@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: mingo@elte.hu, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable PREEMPT_BKL per default
Message-ID: <20051018084706.GA14666@suse.de>
References: <20051016154108.25735ee3.akpm@osdl.org> <20051018074511.GA13182@suse.de> <1129622010.2779.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1129622010.2779.6.camel@laptopd505.fenrus.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Oct 18, Arjan van de Ven wrote:

> On Tue, 2005-10-18 at 09:45 +0200, Olaf Hering wrote:
> > Do not enable this per default during make oldconfig.
> > 'default $foo' should not be abused like that.
> 
> afaik that was done to increase testing.
> This thing shouldn't be a config option at all in a final release imo;
> the config option as I understand it is there to be able to disable it
> during the testing phase in -mm to help diagnose otherwise unexplained
> issues.

CONFIG_PREEMPT_BKL is already in Linus tree.
Its disabled in our configs.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
