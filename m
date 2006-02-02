Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWBBWfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWBBWfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWBBWfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:35:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932374AbWBBWff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:35:35 -0500
Date: Thu, 2 Feb 2006 14:37:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joerg Sommrey <jo@sommrey.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tony@atomide.com,
       len.brown@intel.com, erik@slagter.name, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Message-Id: <20060202143725.46d218dc.akpm@osdl.org>
In-Reply-To: <20060202222407.GB896@sommrey.de>
References: <20060202222407.GB896@sommrey.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Sommrey <jo@sommrey.de> wrote:
>
> This is a processor idle module for AMD SMP 760MP(X) based systems.
>

Len's comments about loss of cache coherency on some machines possibly
causing corruption made me drop this patch.   Was I wrong to do so?
