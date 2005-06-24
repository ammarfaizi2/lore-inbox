Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVFXQL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVFXQL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 12:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVFXQL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 12:11:57 -0400
Received: from dp.samba.org ([66.70.73.150]:25016 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263115AbVFXQK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 12:10:27 -0400
Date: Fri, 24 Jun 2005 09:10:21 -0700
From: Jeremy Allison <jra@samba.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org,
       wli@holomorphy.com, zab@zabbo.net, mason@suse.com
Subject: Re: [PATCH 0/2] Buffered filesystem AIO read/write
Message-ID: <20050624161021.GA25059@jeremy2>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20050620120154.GA4810@in.ibm.com> <20050624104928.GA4408@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050624104928.GA4408@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 04:19:28PM +0530, Suparna Bhattacharya wrote:
> 
> Feedback on (1) seems positive so far, so now moving to (2), here are
> the patches that implement the changes to make filesystem AIO read
> and write truly asynchronous even without O_DIRECT. With these patches
> in place it will no longer be necessary for the POSIX AIO library
> (from Sébastien et al) to force O_DIRECT and memcpy for alignment.
> (Samba should find this useful)

Wonderful ! That's exactly what we need - thanks. I could have fixed this
in userspace but it would be rather ugly.

Jeremy.
