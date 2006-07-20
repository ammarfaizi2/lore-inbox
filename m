Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWGUCW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWGUCW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 22:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWGUCW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 22:22:26 -0400
Received: from tomts27.bellnexxia.net ([209.226.175.101]:44017 "EHLO
	tomts27-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1030440AbWGUCW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 22:22:26 -0400
Date: Thu, 20 Jul 2006 15:21:43 -0700
From: Greg KH <greg@kroah.com>
To: Sergej Pupykin <ps@lx-ltd.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB: count of reading urbs
Message-ID: <20060720222143.GA5399@kroah.com>
References: <m3irls78gk.fsf@lx-ltd.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3irls78gk.fsf@lx-ltd.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 04:43:23PM +0400, Sergej Pupykin wrote:
> 
> Hi, All!
> 
> Please, tell me. If I submit one urb, can I lost data? (If data comes when
> urb callback executed)

No.  How can data be received if you have not submitted an urb?  The way
USB works just does not allow this.

thanks,

greg k-h
