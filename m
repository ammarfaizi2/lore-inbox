Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUKDUL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUKDUL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUKDULi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:11:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:9099 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262396AbUKDUIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:08:49 -0500
Date: Thu, 4 Nov 2004 12:07:53 -0800
From: Greg KH <greg@kroah.com>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 5/5] driver-model: device_add() error path reference counting fix
Message-ID: <20041104200753.GD21149@kroah.com>
References: <20041104070134.GA25567@home-tj.org> <20041104070502.GF25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104070502.GF25567@home-tj.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 04:05:02PM +0900, Tejun Heo wrote:
>  df_05_device_add_ref_fix.patch
> 
>  In device_add(), @dev wan't put'd properly when it has zero length
> bus_id (error path).  Fixed.

Applied, thanks.

greg k-h
