Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752042AbWISEL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbWISEL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 00:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWISEL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 00:11:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21158 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752041AbWISEL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 00:11:56 -0400
Date: Mon, 18 Sep 2006 21:11:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] autofs4 - zero timeout prevents shutdown
Message-Id: <20060918211123.84e583cf.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609191126080.11565@raven.themaw.net>
References: <Pine.LNX.4.64.0609191126080.11565@raven.themaw.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 11:48:15 +0800 (WST)
Ian Kent <raven@themaw.net> wrote:

> If the timeout of an autofs mount is set to zero then umounts
> are disabled. This works fine, however the kernel module checks
> the expire timeout and goes no further if it is zero. This is
> not the right thing to do at shutdown as the module is passed
> an option to expire mounts regardless of their timeout setting.

Is this a new feature, or a regression since <when>?

Thanks.
