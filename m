Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbUKDTHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUKDTHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUKDTE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:04:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:26055 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262355AbUKDTDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:03:25 -0500
Date: Thu, 4 Nov 2004 11:00:06 -0800
From: Greg KH <greg@kroah.com>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 4/5] driver-model: kobject_add() error path reference counting fix
Message-ID: <20041104190006.GC17756@kroah.com>
References: <20041104070134.GA25567@home-tj.org> <20041104070431.GE25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104070431.GE25567@home-tj.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 04:04:32PM +0900, Tejun Heo wrote:
>  df_04_kobject_add_ref_fix.patch
> 
>  In kobject_add(), @kobj wasn't put'd properly on error path.  This
> patch fixes it.
> 
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

Applied, thanks.

greg k-h
