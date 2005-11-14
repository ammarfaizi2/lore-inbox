Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVKNB7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVKNB7R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 20:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVKNB7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 20:59:17 -0500
Received: from [218.25.172.144] ([218.25.172.144]:61969 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1750750AbVKNB7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 20:59:16 -0500
Date: Mon, 14 Nov 2005 09:59:01 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Christian Unger <c.unger@uq.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kjournald - what does this process actually do?
Message-ID: <20051114015901.GA2471@localhost.localdomain>
References: <200511141122.40638.c.unger@uq.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511141122.40638.c.unger@uq.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 11:22:40AM +1000, Christian Unger wrote:
> Hi there
> 
> I was wondering, what does kjournald actually do. I know it relates to using 
> jounralised file systems such as ext3 and reiserfs, but that's about it. I 
> wasn't really hoping to dig through source code, but :P ...

Commit at every 5 seconds intervals.

> 
> Also, what would cause a kjournald process to go down?

freeze, umount and on-error.

		Coywolf
