Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbUCJPoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbUCJPoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:44:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43229 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262665AbUCJPoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:44:03 -0500
Date: Wed, 10 Mar 2004 16:44:02 +0100
From: Jan Kara <jack@suse.cz>
To: "Anders K. Pedersen" <akp@cohaesio.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 userspace freeze
Message-ID: <20040310154402.GE10765@atrey.karlin.mff.cuni.cz>
References: <222BE5975A4813449559163F8F8CF503458432@cohsrv1.cohaesio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <222BE5975A4813449559163F8F8CF503458432@cohsrv1.cohaesio.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> I will try this to night; just to make sure I understand you correctly:
> You just want me to turn off quotas on all file systems (currently they
> are in use on one of them), and it is not necessary to recompile the
> kernel without quota support?
  Yes, just turning quotas off with quotaoff(8) should be enough to rule
out possible deadlocks caused by quotas.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
