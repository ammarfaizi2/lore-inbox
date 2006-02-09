Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030619AbWBIDlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030619AbWBIDlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 22:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbWBIDlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 22:41:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9706 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030619AbWBIDlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 22:41:18 -0500
Date: Wed, 8 Feb 2006 19:40:57 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marc Koschewski <marc@osknowledge.org>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH GIT] drivers/block/ub.c - misc. cleanup/indentation,
 removed unneeded return
Message-Id: <20060208194057.55b02719.zaitcev@redhat.com>
In-Reply-To: <mailman.1139418724.17734.linux-kernel2news@redhat.com>
References: <mailman.1139418724.17734.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006 10:29:15 +0100, Marc Koschewski <marc@osknowledge.org> wrote:

> I created this little patch while reading through drivers/block/ub.c. It fixes
> some indentation/whitespace as well as some empty commenting, an hardcoded
> module name and an unneeded return.

I strongly disagree.

The only segment which has some merit is the one which replaces the .name
with DRV_NAME. It could have been "usb-block" or something, but we probably
won't be using that, so it's all right.

But the rest is quite bad, the worst being indenting the switch statement.

Is there nothing else you can do in the whole kernel?

-- Pete
