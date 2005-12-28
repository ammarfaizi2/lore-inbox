Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVL1JZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVL1JZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 04:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVL1JZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 04:25:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58892 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932509AbVL1JZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 04:25:45 -0500
Date: Wed, 28 Dec 2005 10:27:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] elevator: elv_try_merge() cleanup
Message-ID: <20051228092716.GB2772@suse.de>
References: <20051227033652.GA12214@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051227033652.GA12214@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27 2005, Coywolf Qi Hunt wrote:
> Cleanup: make elv_try_merge() static, kill the dead declaration of
> elv_try_last_merge().

Looks good, it's an artifact of the redone merging stuff that Tejun did
(it used to be called by io schedulers). Applied.

-- 
Jens Axboe

