Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTICBBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTICBBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:01:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:49068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261168AbTICBBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:01:05 -0400
Date: Tue, 2 Sep 2003 17:27:43 -0700
From: Greg KH <greg@kroah.com>
To: Tomas Konir <moje@vabo.cz>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@vger.kernel.org
Subject: Re: 2.4.22 + XFS oops with palm usb sync
Message-ID: <20030903002743.GA21349@kroah.com>
References: <Pine.LNX.4.53.0309022000260.7734@moje.vabo.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309022000260.7734@moje.vabo.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 08:07:09PM +0200, Tomas Konir wrote:
> 
> Hi
> 2.4.22 periodically oops after synchronization my palm (Tungsten T).
> Only XFS patches in kernel and no other. On usb was palm and Microsoft 
> mouse. (sometimes with previous kernels the mouse was disconnected after 
> synchronization). 

Known bug, sorry.  Use 2.6 instead.

Search the archives for details on what needs to be backported to 2.4 if
you really want to fix this problem.

Good luck,

greg k-h
