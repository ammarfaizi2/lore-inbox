Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbUKSMlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbUKSMlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUKSMlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:41:07 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:21397 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261372AbUKSMk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:40:58 -0500
Date: Fri, 19 Nov 2004 13:40:55 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Paul Menage <menage@google.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] RFC: let x86_64 no longer define X86
Message-ID: <20041119124055.GG21483@wotan.suse.de>
References: <20041119005117.GM4943@stusta.de> <6599ad8304111817317880dfe5@mail.google.com> <20041119122827.GB22981@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119122827.GB22981@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The most important improvement would be to prevent such bugs and to have 
> the X86_64 dependency explicitely stated.

This would just end up with me having to hunt through all the drivers
all the time and enabling drivers that need to be enabled on x86-64 too.

It's much easier to disable the few drivers that are broken with !X86_64. 

Again please don't do it. It will just cause more work long term.

-Andi
