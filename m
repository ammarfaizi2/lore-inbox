Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbUKDTEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbUKDTEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUKDTEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:04:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:25287 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262354AbUKDTDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:03:23 -0500
Date: Thu, 4 Nov 2004 10:59:31 -0800
From: Greg KH <greg@kroah.com>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 3/5] driver-model: sysfs_release() dangling pointer reference fix
Message-ID: <20041104185931.GB17756@kroah.com>
References: <20041104070134.GA25567@home-tj.org> <20041104070337.GD25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104070337.GD25567@home-tj.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 04:03:37PM +0900, Tejun Heo wrote:
>  df_03_sysfs_release_fix.patch
> 
>  Some attributes are allocated dynamically (e.g. module and device
> parameters) and are usually deallocated when the assoicated kobject is
> released.  So, it's not safe to access attr after putting the kobject.
> 
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

Applied, thanks.

greg k-h
