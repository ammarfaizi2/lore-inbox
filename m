Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVI2B5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVI2B5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVI2B5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:57:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45527 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751306AbVI2B5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:57:21 -0400
Date: Thu, 29 Sep 2005 02:57:20 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: pinotj@club-internet.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.14-rc2] ext3: fix build warning if !quota
Message-ID: <20050929015720.GQ7992@ftp.linux.org.uk>
References: <mnet1.1127958413.3944.pinotj@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mnet1.1127958413.3944.pinotj@club-internet.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 03:46:53AM +0200, pinotj@club-internet.fr wrote:
> Hi,
> 
> (My first e-mail seems to be lost somewhere, here is a second try)
> 
> sbi is not used if quota is not defined. This leads to a useless
> variable after preprocessing and a build warning.
> 
> This moves the declaration in right place.

... and puts declaration in the middle of code.
