Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbUKQTNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbUKQTNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUKQTNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:13:15 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:27143 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262460AbUKQTI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:08:57 -0500
Date: Wed, 17 Nov 2004 19:08:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify: vfs_permission was replaced
Message-ID: <20041117190850.GA11682@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@novell.com>, ttb@tentacle.dhs.org,
	linux-kernel@vger.kernel.org
References: <1100710677.6280.2.camel@betsy.boston.ximian.com> <1100714560.6280.7.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100714560.6280.7.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:02:40PM -0500, Robert Love wrote:
> John,
> 
> In 2.6.10-rc, vfs_permission() was replaced by generic_permission(),
> which also has a slightly changed behavior and argument list.

And using either of them was/is totally bogus.  It's a helper for filesystems,
not a general API.

