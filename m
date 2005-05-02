Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVEBX0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVEBX0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 19:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVEBXYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 19:24:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:11431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261228AbVEBXXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 19:23:48 -0400
Date: Mon, 2 May 2005 16:05:01 -0700
From: Greg KH <greg@kroah.com>
To: Colin Leroy <colin@colino.net>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-usb-devel@lists.sourceforge.net" 
	<linux-usb-devel@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Jeroen Vreeken <pe1rxq@amsat.org>
Subject: Re: [PATCH] check for device in zd1201_resume
Message-ID: <20050502230500.GB5186@kroah.com>
References: <20050501112910.2ffd2095@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050501112910.2ffd2095@jack.colino.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 11:29:10AM +0200, Colin Leroy wrote:
> Hi,
> 
> My patch adding PM support for zd1201 didn't check for the device on
> resume, which can oops if the device has been removed.
> 
> This patch fixes it.


Applied, thanks.

greg k-h

