Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965319AbVKGUGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965319AbVKGUGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965324AbVKGUFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:05:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13269 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964901AbVKGUF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:05:28 -0500
Date: Mon, 7 Nov 2005 14:04:31 -0600
From: David Teigland <teigland@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-cluster@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/dlm/: possible cleanups
Message-ID: <20051107200431.GC20531@redhat.com>
References: <20051104120640.GB5587@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104120640.GB5587@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 01:06:40PM +0100, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - every file should #include the headers containing the prototypes for
>   it's global functions

Including unnecessary headers doesn't sound right.

> - make needlessly global functions static
> - #if 0 the following unused global functions:
>   - device.c: dlm_device_free_devices
>   - lock.c: dlm_remove_from_waiters
>   - lockspace.c: dlm_find_lockspace_name

I've removed the unused functions and added the statics.

Thanks,
Dave

