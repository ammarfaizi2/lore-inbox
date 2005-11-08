Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVKHPtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVKHPtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVKHPtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:49:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63651 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965101AbVKHPtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:49:51 -0500
Date: Tue, 8 Nov 2005 15:48:28 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [2.6 patch] drivers/md/kcopyd.c: remove kcopyd_cancel()
Message-ID: <20051108154828.GX26394@agk.surrey.redhat.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org
References: <20051108134419.GR3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108134419.GR3847@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 02:44:19PM +0100, Adrian Bunk wrote:
> A function that is
> - not used
> - empty
> - without a prototype in any header file
> should be removed.
 
I'd rather you submitted a patch to complete the function and invoke it
in the appropriate place:-)  But please don't remove comments indicating 
missing functionality: commenting it out till it's written would be better.

Alasdair
-- 
agk@redhat.com

> -/*
> - * Cancels a kcopyd job, eg. someone might be deactivating a
> - * mirror.
> - */
> -int kcopyd_cancel(struct kcopyd_job *job, int block)
> -{
> -	/* FIXME: finish */
> -	return -1;
> -}

