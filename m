Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVBKVg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVBKVg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVBKVg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:36:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:32215 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262349AbVBKVgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:36:55 -0500
Date: Fri, 11 Feb 2005 13:36:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper: multipath
Message-Id: <20050211133632.2277fed9.akpm@osdl.org>
In-Reply-To: <20050211173143.GA11278@infradead.org>
References: <20050211171506.GX10195@agk.surrey.redhat.com>
	<20050211173143.GA11278@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > +EXPORT_SYMBOL(dm_register_path_selector);
>  > +EXPORT_SYMBOL(dm_unregister_path_selector);
> 
>  I though we agreed to only allow GPL'ed path selectors at OSDL?

(OSDL?)

Yup, this should be _GPL.  Anything which uses these exports is a derived
work, isn't it?
